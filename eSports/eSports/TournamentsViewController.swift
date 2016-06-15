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
    
    var discipline: Discipline?
    var region: Region?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let discipline = discipline {
            toornamentClient.getTournaments(discipline.id, beforeStart: "2016-04-08", sort: "date_desc") { result in
                if let tournaments = result.value {
                    self.tournaments = tournaments
                }
                print(self.tournaments.count)
                self.tableView.reloadData()
            }
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
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("matchSegue", sender: self)
//    }
    
//    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
//        if let nextIndexPath = context.nextFocusedIndexPath {
////            regionImageView.image = tournaments[nextIndexPath.row].image
//            
//        }
//    }
    
}

