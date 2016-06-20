//
//  MatchViewController.swift
//  eSports
//
//  Created by guilherme babugia on 13/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

private let collectionReuseIdentifier = "weekDayCell"
private let tableReuseIdentifier = "matchCell"


class MatchViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tournamentImageView: UIImageView!
    @IBOutlet private weak var tournamentTitleLabel: UILabel!
    @IBOutlet private weak var tournamentDateLabel: UILabel!
    @IBOutlet private weak var tournamentCityLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    private let toornamentClient = ToornamentController()
    var matchs = [Match]()
    var tournament: Tournament?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = UIColor.eSports_DarkBlue()
        activityIndicator.layer.hidden = false
        activityIndicator.startAnimating()

        
        tournamentCityLabel.text = ""
        tournamentDateLabel.text = ""

        tournamentTitleLabel.numberOfLines = 1
        tournamentTitleLabel.minimumScaleFactor = (1.0 / tournamentTitleLabel.font.pointSize)
        tournamentTitleLabel.adjustsFontSizeToFitWidth = true
        
        headerView.backgroundColor = UIColor.eSports_DarkGray()
        headerView.layer.shadowColor = UIColor.eSports_LightBlue().CGColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        headerView.layer.shadowOpacity = 0.8
        headerView.layer.shadowRadius = 10
        
        tournamentCityLabel.tintColor = UIColor.eSports_LightGray()
        tournamentDateLabel.tintColor = UIColor.eSports_LightGray()
        
        if let tournament = tournament {
            
            tournamentTitleLabel.text = tournament.name
            tournamentImageView.image = UIImage(named: "\(tournament.discipline)_icon")
            print(tournament.name)
            
            if let dateStart = tournament.dateStart, dateEnd = tournament.dateEnd {
                tournamentDateLabel.text = "\(dateStart) - \(dateEnd)"
            }
            
            if let location = tournament.location, country = tournament.country {
                tournamentCityLabel.text = "\(location) - \(country)"
            }
            
            toornamentClient.getMatchesByTournament(tournament.id, hasResult: true, sort: "latest") { [weak self] result in
                if let matchs = result.value {
                    self?.matchs = matchs
                }
                
                self?.tableView.reloadData()
                self?.activityIndicator.layer.hidden = true
                self?.activityIndicator.stopAnimating()
            }
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gamesSegue" {
            let row = sender as! Int
            let vc = segue.destinationViewController as? GamesViewController
            vc?.match = matchs[row]
        }
    }
}

extension MatchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableReuseIdentifier) as? MatchCell
        cell?.configureCell(matchs[indexPath.row])
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("gamesSegue", sender: indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

