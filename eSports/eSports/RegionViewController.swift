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

    let toornamentClient = ToornamentController()
    var tournaments = [Tournament]()
    var matchs = [Match]()
    var discipline: Discipline?
    var participants = [Participant]()
    
    let regions = ["CS:GO_logo", "Dota2_logo", "LOL_logo"]
    
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
}

extension RegionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regions.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? RegionCell
        cell?.configureCell(regions[indexPath.row])
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
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as? RegionCell
        performSegueWithIdentifier("tournamentSegue", sender: cell)
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldUpdateFocusInContext context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        
        guard let nextFocusedView = context.nextFocusedView else { return }
        
        let layer = nextFocusedView.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 30
        
        if let previousView = context.previouslyFocusedView {
            previousView.layer.shadowOffset = CGSizeMake(0,0)
            previousView.layer.shadowOpacity = 0.0
        }
        
    }
    
}

