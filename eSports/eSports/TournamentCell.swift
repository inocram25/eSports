//
//  TournamentCell.swift
//  eSports
//
//  Created by guilherme babugia on 15/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class TournamentCell: UITableViewCell {
    
    @IBOutlet private weak var mapImageView: UIImageView!
    @IBOutlet private weak var tournamentNameLabel: UILabel!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var dateTournamentLabel: UILabel!
    @IBOutlet private weak var numberOfTeamsLabel: UILabel!
    
    @IBOutlet private weak var backView: TrapeziumView!
    var gradient: CAGradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityNameLabel.textColor = UIColor.eSports_LightGray()
        dateTournamentLabel.textColor = UIColor.eSports_LightGray()
        numberOfTeamsLabel.textColor = UIColor.eSports_LightGray()
        
        
        gradient.colors = [UIColor.eSports_DarkGray().colorWithAlphaComponent(0.5).CGColor, UIColor.eSports_LightGray().colorWithAlphaComponent(0.7).CGColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = backView.frame
        
        backView.layer.insertSublayer(gradient, atIndex: 0)
        
        tournamentNameLabel.numberOfLines = 1
        tournamentNameLabel.minimumScaleFactor = (8.0 / tournamentNameLabel.font.pointSize)
        tournamentNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if (context.nextFocusedView == self) {
            
            backgroundColor = UIColor.clearColor()
            
            layer.shadowColor = UIColor.eSports_LightBlue().CGColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.8
            layer.shadowRadius = 10
            
            gradient.removeFromSuperlayer()
            
            gradient.colors = [UIColor.eSports_Black().colorWithAlphaComponent(0.5).CGColor, UIColor.eSports_DarkBlue().colorWithAlphaComponent(1.0).CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = backView.frame
            
            backView.layer.insertSublayer(gradient, atIndex: 0)
            
            
            UIView.animateWithDuration(0.2) {
                self.transform = CGAffineTransformMakeScale(1.05,1.0)
            }
            
        } else {
            backgroundColor = UIColor.clearColor()
            layer.shadowColor = UIColor.clearColor().CGColor
            
            gradient.removeFromSuperlayer()
            
            gradient.colors = [UIColor.eSports_DarkGray().colorWithAlphaComponent(0.5).CGColor, UIColor.eSports_LightGray().colorWithAlphaComponent(0.7).CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = backView.frame
            
            backView.layer.insertSublayer(gradient, atIndex: 0)
            
            
            UIView.animateWithDuration(0.2) {
                self.transform = CGAffineTransformMakeScale(1.0,1.0)
            }
        }
    }

    func configureCell(tournament: Tournament) {
        
        tournamentNameLabel.text = tournament.fullName
        cityNameLabel.text = tournament.location
        numberOfTeamsLabel.text = "\(tournament.size) Teams"
        
        if let country = tournament.country?.lowercaseString {
            mapImageView.image = UIImage(named: country)
        }
        
        if let dateStart = tournament.dateStart, dateEnd = tournament.dateEnd {
            dateTournamentLabel.text = "\(dateStart) - \(dateEnd)"
        }
    }
}
