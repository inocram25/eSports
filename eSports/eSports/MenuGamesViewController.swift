//
//  MenuGamesViewController.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/7/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit



private let reuseIdentifier = "gamesCell"

class MenuGamesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let toornamentClient = ToornamentController()
    var games = [Game]()
    var tournaments = [Tournament]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        toornamentClient.getGames { result in
            if let games = result.value {
                self.games = games
                self.collectionView?.reloadData()
            }
        }
        
        toornamentClient.getTournaments("counterstrike_go", beforeStart: "2016-06-09", sort: "date_desc") { result in
            if let tournaments = result.value {
                self.tournaments = tournaments
            }
            self.tournaments.forEach { t in
                print("\(t.country) -- \(t.name)")
            }
        }

    }

}


extension MenuGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? GamesCollectionViewCell
        
        cell?.configureCell(games[indexPath.row])
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
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
 
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
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
