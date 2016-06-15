//
//  TournamentCell.swift
//  eSports
//
//  Created by guilherme babugia on 15/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class TournamentCell: UITableViewCell {
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var tournamentNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateTournamentLabel: UILabel!
    @IBOutlet weak var numberOfTeamsLabel: UILabel!
    
    @IBOutlet weak var backView: TrapeziumView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(tournament: Tournament) {
        
        tournamentNameLabel.text = tournament.fullName
        cityNameLabel.text = tournament.location
        dateTournamentLabel.text = "\(tournament.dateStart) - \(tournament.dateEnd)" //FORMATAR DATA DE UM JEITO DECENTE
        numberOfTeamsLabel.text = "\(tournament.size) Teams"
        mapImageView.image = UIImage(named: "br")
    }
}
