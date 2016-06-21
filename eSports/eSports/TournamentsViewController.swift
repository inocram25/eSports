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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!
    
    
    var discipline: Discipline?
    var region: Region?
    
    let countryDictionary = ["NA":["AG","AI","AN","AW","BB","BL","BM","BS","BZ","CA","CR","CU","DM","DO","GD","GL","GP","GT","HN","HT","JM","KN","KY","LC","MF","MQ","MS","MX","NI","PM","PR","SV","TC","TT","VC","VG","VI","PA","US"],
                             "EU":["AL","AT","AX","BA","BG","BY","CZ","DE","DK","EE","EU","FI","FO","FR","FX","GB","GG","GR","HR","IE","IM","IT","JE","LI","LU","LV","MD","ME","MK","MT","NL","PL","RO","RU","SI","SK","SM","TR","UA","VA","AD","LT","MC","NO","BE","PT","CH","PY","RS","SE","SJ","ES","GI","HU","IS"],
                             "AS":["AE","AF","AM","AP","AZ","BD","BH","BN","BT","CC","CN","CX","CY","GE","HK","ID","IL","IN","IO","IQ","IR","JO","JP","KG","KH","KP","KR","KW","KZ","LA","LB","LK","MM","MN","MO","MV","MY","NP","OM","PH","PK","PS","QA","SA","SG","SY","TH","TJ","TL","TM","TW","UZ","VN","YE"],
                             "AF":["AO","BF","BI","BJ","BW","CD","CF","CG","CI","CM","CV","DJ","DZ","EG","EH","ER","ET","GA","GH","GM","GN","GQ","GW","KE","KM","LR","LS","LY","MA","MG","ML","MR","MU","MW","MZ","NA","NE","NG","RE","RW","SC","SD","SH","SL","SN","SO","ST","SZ","TD","TG","TN","TZ","UG","YT","ZA","ZW","ZM"],
                             "OC":["AS","AU","CK","FJ","FM","GU","KI","MH","MP","NC","NF","NR","NU","NZ","PF","PG","PN","PW","SB","TK","TO","TV","UM","VU","WF","WS"]]
    
    func tournamentsByContinent(continent:String, tournamentList: [Tournament]) -> [Tournament] {
        
        return tournamentList.filter { (tournament) -> Bool in
            if let country = tournament.country {
                print("\(country) -- \(continent) = \(countryDictionary[continent]!.contains(country))")
                return countryDictionary[continent]!.contains(country)
            }
            return false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = UIColor.eSports_DarkBlue()
        activityIndicator.layer.hidden = false
        activityIndicator.startAnimating()
        
        regionLabel.textColor = UIColor.eSports_MediumGray()
        
        let currentDate = "\(NSDate().year)-\(NSDate().month)-\(NSDate().day)"
        print(currentDate)
        
        if let discipline = discipline {
            toornamentClient.getTournaments(discipline.id, beforeStart: currentDate, sort: "date_desc") { [weak self] result in
                if let tournaments = result.value {
                    self?.tournaments = tournaments
                }
                
                if let initial = self!.region?.initials, tournaments = self?.tournaments {
                    let x = self?.tournamentsByContinent(initial, tournamentList: tournaments)
                    
                    print(x?.count)
                    
                    self?.tournaments = x!
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
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
}

