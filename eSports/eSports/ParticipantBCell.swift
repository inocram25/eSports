//
//  ParticipantBCell.swift
//  eSports
//
//  Created by guilherme babugia on 17/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class ParticipantBCell: UITableViewCell {
    
    @IBOutlet weak var backView: ReverseTrapeziumView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var participantNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = UIColor.whiteColor()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.lightGrayColor().colorWithAlphaComponent(0.8).CGColor, UIColor.eSports_DarkGray().colorWithAlphaComponent(0.8).CGColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = backView.frame
        
        backView.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    func configureCell(player: Lineup) {
        participantNameLabel.text = player.name
        
        if let country = player.country?.lowercaseString {
            flagImageView.image = UIImage(named: country)
        }
    }

}
