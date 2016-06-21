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
    
    private let regions = [Region.NorthAmerica, Region.Europe, Region.Asia, Region.Africa, Region.SouthAmerica, Region.Oceania]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let discipline = discipline {
            imageView.image = UIImage(named: "\(discipline.shortname!)_logo")
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tournamentSegue" {
            let row = sender as! Int
            let vc = segue.destinationViewController as? TournamentsViewController
            vc?.discipline = discipline!
            vc?.region = regions[row]
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
        performSegueWithIdentifier("tournamentSegue", sender: indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let nextIndexPath = context.nextFocusedIndexPath {
            regionImageView.image = regions[nextIndexPath.row].imageHighlighted
//            regionImageView.transform = CGAffineTransformMakeRotation((-10 * CGFloat(M_PI)) / 180.0)

        }
    }

}

