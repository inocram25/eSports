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
    private let toornamentClient = ToornamentController()
    var matchs = [Match]()
    var tournament: Tournament?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
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
        
        if let tournament = tournament {
            
            tournamentTitleLabel.text = tournament.fullName
            tournamentDateLabel.text = tournament.dateStart
            tournamentCityLabel.text = tournament.location
            
            toornamentClient.getMatchesByTournament(tournament.id, hasResult: true, sort: "latest") { result in
                if let matchs = result.value {
                    self.matchs = matchs
                }
                self.tableView.reloadData()
            }
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
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("tournamentSegue", sender: indexPath.row)
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
}

extension MatchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionReuseIdentifier, forIndexPath: indexPath) as? WeekDayCell
        cell?.configureCell("")
        return cell!
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let border = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let itemWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let totalWidth = collectionView.bounds.width - border
        let numberOfCells = floor(totalWidth / itemWidth)
        let usedSpace = itemWidth * numberOfCells
        let bonusSpace = flowLayout.minimumInteritemSpacing * numberOfCells
        let edgeInsets = floor((totalWidth - usedSpace + bonusSpace) / (numberOfCells + 1.0))
        
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: edgeInsets, bottom: flowLayout.sectionInset.bottom, right: edgeInsets)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        
    }
    
    func collectionView(collectionView: UICollectionView, shouldUpdateFocusInContext context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
}

