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

    func configureCell(game: Game, discipline: String?) {
        
        var resultA = 2
        var resultB = 2
        
        if let result = game.opponents[0].result {
            resultA = result
        }
        
        if let result = game.opponents[1].result {
            resultB = result
        }
        
        leftResultLabel.textColor = gameResult(rawValue: resultA)!.color
        rightResultLabel.textColor = gameResult(rawValue: resultB)!.color
        
        if let discipline = discipline {
            if discipline == "counterstrike_go" {
                if let map = game.map {
                    gameCountLabel.text = map
                }
                else {
                    gameCountLabel.text = "Game \(game.number)"
                }
                
                if let score = game.opponents[0].score {
                    leftResultLabel.text = "\(score)"
                }
                else {
                    leftResultLabel.text = gameResult(rawValue: resultA)!.description
                }
                
                if let score = game.opponents[1].score {
                    rightResultLabel.text = "\(score)"
                }
                else {
                    rightResultLabel.text = gameResult(rawValue: resultB)!.description
                }
            }
            else {
                gameCountLabel.text = "Game \(game.number)"
            }
        }
        else {
            gameCountLabel.text = "Game \(game.number)"
            leftResultLabel.text = gameResult(rawValue: resultA)!.description
            rightResultLabel.text = gameResult(rawValue: resultB)!.description
        }
    
    }

}
