//
//  TournamentsViewController.swift
//  eSports
//
//  Created by guilherme babugia on 15/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "tournamentsCell"

class TournamentsViewController: UIViewController {
    
    private let toornamentClient = ToornamentController()
    private var tournaments = [Tournament]()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var regionImageView: UIImageView!
    @IBOutlet private weak var regionInitialsLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    
    var discipline: Discipline?
    var region: Region?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        regionLabel.textColor = UIColor.eSports_MediumGray()
        
        let currentDate = "\(NSDate().year)-\(NSDate().month)-\(NSDate().day)"
        print(currentDate)
        
        if let discipline = discipline {
            toornamentClient.getTournaments(discipline.id, beforeStart: currentDate, sort: "date_desc") { [weak self] result in
                if let tournaments = result.value {
                    self?.tournaments = tournaments
                }
                self?.tableView.reloadData()
            }
        }
     
        if let region = region {
            regionImageView.image = region.image
            regionLabel.text = region.description
            regionInitialsLabel.text = "\(region.initials)|"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "matchSegue" {
            let row = sender as! Int
            let vc = segue.destinationViewController as? MatchViewController
            vc?.tournament = tournaments[row]
        }
    }
}

extension TournamentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? TournamentCell
        cell?.configureCell(tournaments[indexPath.row])
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("matchSegue", sender: indexPath.row)
    }
    
    
}

