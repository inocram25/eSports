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

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let toornamentClient = ToornamentController()
    var disciplines = [Discipline]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let group = dispatch_group_create()
        
        dispatch_group_enter(group)
        toornamentClient.getDisciplinesById("counterstrike_go") { [weak self] result in
            if var discipline = result.value {
                discipline.image = UIImage(named: "csgo_poster")
                self?.disciplines.append(discipline)
            }
            dispatch_group_leave(group)
        }
        
        dispatch_group_enter(group)
        toornamentClient.getDisciplinesById("dota2") { [weak self] result in
            if var discipline = result.value {
                discipline.image = UIImage(named: "dota2_poster")
                self?.disciplines.append(discipline)
            }
            dispatch_group_leave(group)

        }
        
        dispatch_group_enter(group)
        toornamentClient.getDisciplinesById("leagueoflegends") { [weak self] result in
            if var discipline = result.value {
                discipline.image = UIImage(named: "lol_poster")
                self?.disciplines.append(discipline)
            }
            dispatch_group_leave(group)
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tournamentSegue" {
            let vc = segue.destinationViewController as? RegionViewController
            let cell = sender as? GamesCollectionViewCell
            vc?.discipline = cell?.currentGame
        }
    }

}


extension MenuGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return disciplines.count > 3 ? 3 : disciplines.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? GamesCollectionViewCell
        cell?.configureCell(disciplines[indexPath.row])
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
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as? GamesCollectionViewCell
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
