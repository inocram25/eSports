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

    override func awakeFromNib() {
        super.awakeFromNib()
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
