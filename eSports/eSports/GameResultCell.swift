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
        
        if let result = game.opponents[0].result {
            leftResultLabel.text = gameResult(rawValue: result)!.description
            leftResultLabel.textColor = gameResult(rawValue: result)!.color
        }
        
        if let result = game.opponents[1].result {
            rightResultLabel.text = gameResult(rawValue: result)!.description
            rightResultLabel.textColor = gameResult(rawValue: result)!.color
        }

    }

}
