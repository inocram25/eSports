//
//  GameResultCell.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/17/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class GameResultCell: UITableViewCell {
    @IBOutlet private weak var gameCountLabel: UILabel!
    @IBOutlet private weak var leftResultLabel: UILabel!
    @IBOutlet private weak var rightResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(game: Game) {
        gameCountLabel.text = "Game \(game.number)"
        
        leftResultLabel.text = gameResult(rawValue: game.opponents[0].result!)?.description
        leftResultLabel.textColor = gameResult(rawValue: game.opponents[0].result!)?.color
        
        rightResultLabel.text = gameResult(rawValue: game.opponents[1].result!)?.description
        rightResultLabel.textColor = gameResult(rawValue: game.opponents[1].result!)?.color

    }

}
