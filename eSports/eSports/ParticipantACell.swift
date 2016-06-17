//
//  GameCell.swift
//  eSports
//
//  Created by guilherme babugia on 17/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class ParticipantACell: UITableViewCell {
    
    @IBOutlet weak var backView: TrapeziumView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var participantNameLabel: UILabel!
    
    var gradient: CAGradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(player: Lineup) {
        participantNameLabel.text = player.name
        
        if let country = player.country?.lowercaseString {
            flagImageView.image = UIImage(named: country)
        }
    }
}