//
//  TournamentsViewController.swift
//  eSports
//
//  Created by guilherme babugia on 15/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reuseIdentifier = "tournamentsCell"

class TournamentsViewController: UIViewController {
    
    private let toornamentClient = ToornamentController()
    private var tournaments = [Tournament]()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var regionImageView: UIImageView!
    @IBOutlet private weak var regionInitialsLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var activityView: UIView!
    
    
    var discipline: Discipline?
    var region: Region?
    
    private var continentDictionary = ["NA": [""], "EU":[""], "AS":[""],
                                       "AF":[""], "OC":[""], "SA":[""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readContinentsJSON()
        
        activityIndicator.color = UIColor.eSports_DarkBlue()
        activityIndicator.layer.hidden = false
        activityIndicator.startAnimating()
        
        let currentDate = "\(NSDate().year)-\(NSDate().month)-\(NSDate().day)"
        
        if let discipline = discipline {
            toornamentClient.getTournaments(discipline.id, beforeStart: currentDate, sort: "date_desc") { [weak self] result in
                
                guard let weakSelf = self else { return }
                
                if let tournaments = result.value {
                    self?.tournaments = tournaments
                }
                
                if let initial = weakSelf.region?.initials {
                    //Get filtered tournaments for each region
                    self?.tournaments = weakSelf.tournamentsByContinent(initial, tournamentList: weakSelf.tournaments)
                }
                
                self?.activityView.hidden = true
                self?.tableView.reloadData()
                self?.activityIndicator.layer.hidden = true
                self?.activityIndicator.stopAnimating()
            }
        }
     
        if let region = region {
            regionImageView.image = region.image
            regionLabel.text = region.description
            regionLabel.textColor = UIColor.eSports_MediumGray()
            regionInitialsLabel.text = "\(region.initials)|"
        }
    }
    
    func tournamentsByContinent(continent:String, tournamentList: [Tournament]) -> [Tournament] {
        return tournamentList.filter { tournament in
            if let country = tournament.country {
                return continentDictionary[continent]!.contains(country)
            }
            return false
        }
    }
    
    
    func readContinentsJSON() {
        let url = NSBundle.mainBundle().URLForResource("Countries+Continents", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            let json = JSON(object)
            
            for (_,subJson):(String, JSON) in json {
                
                if subJson["continent"].stringValue == "NA" {
                    continentDictionary["NA"]!.append(subJson["country"].stringValue)
                }
                else if subJson["continent"].stringValue == "EU" {
                    continentDictionary["EU"]!.append(subJson["country"].stringValue)
                }
                else if subJson["continent"].stringValue == "AS" {
                    continentDictionary["AS"]!.append(subJson["country"].stringValue)
                }
                else if subJson["continent"].stringValue == "AF" {
                    continentDictionary["AF"]!.append(subJson["country"].stringValue)
                }
                else if subJson["continent"].stringValue == "SA" {
                    continentDictionary["SA"]!.append(subJson["country"].stringValue)
                }
            }
            
        } catch {
            print("Error to read Continents JSON")
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
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}
