//
//  TournamentViewController.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/10/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "regionsCell"


class RegionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var regionImageView: UIImageView!

    let toornamentClient = ToornamentController()
    var tournaments = [Tournament]()
    var matchs = [Match]()
    var discipline: Discipline?
    var participants = [Participant]()
    
    let regions = [Region.NorthAmerica, Region.Europe, Region.Asia, Region.Africa, Region.SouthAmerica, Region.Oceania]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let discipline = discipline {
            print(discipline.shortname)
            imageView.image = UIImage(named: "\(discipline.shortname!)_logo")
        }
        
//        if let discipline = discipline {
//            toornamentClient.getTournaments(discipline.id, beforeStart: "2016-04-08", sort: "date_desc") { result in
//                if let tournaments = result.value {
//                    self.tournaments = tournaments
//                }
//                self.tournaments.forEach { t in
//                    print("\(t.id) -- \(t.name)")
//                }
//            }
//        }
        
        // match id astralis x NRG = 5733266170cb4913198b4570
        //match id lg x splyce = 569f970c150ba039518b4583
                
        // dreamhack austin = 569f96a9140ba0be3a8b4568 , 
//        eleague group c = 5733261f150ba005238b4567
        // ESL Cologne = 5668664d150ba0d80a8b45ed
        
//        toornamentClient.getParticipantsByTournament("5668664d150ba0d80a8b45ed") { result in
//            
//            if let participants = result.value {
//                self.participants = participants
//            }
//            self.participants.forEach { p in
//                
//                print("\(p.name) ---- \(p.country)")
//                p.lineup?.forEach { l in
//                    print(l.name)
//                }
//            }
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "matchSegue" {
            let vc = segue.destinationViewController as? MatchViewController
            vc?.discipline = discipline
        }
    }
    
}

extension RegionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? RegionCell
        cell?.regionLabel.text = regions[indexPath.row].description
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("matchSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let nextIndexPath = context.nextFocusedIndexPath {
            regionImageView.image = regions[nextIndexPath.row].image

        }
    }

}

