//
//  MatchCell.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/16/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {
    
    //Team A
    @IBOutlet private weak var teamALogoImageView: UIImageView!
    @IBOutlet private weak var teamALabel: UILabel!
    @IBOutlet private weak var teamAScoreLabel: UILabel!

    //Team B
    @IBOutlet private weak var teamBLogoImageView: UIImageView!
    @IBOutlet private weak var teamBLabel: UILabel!
    @IBOutlet private weak var teamBScoreLabel: UILabel!
    
    @IBOutlet private weak var teamABackView: TrapeziumView!
    @IBOutlet private weak var teamBBackView: ReverseTrapeziumView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        backgroundColor = UIColor.clearColor()

        if (context.nextFocusedView == self) {
            
            layer.shadowColor = UIColor.eSports_LightBlue().CGColor
            layer.shadowOffset = CGSize(width: 0, height: 3)
            layer.shadowOpacity = 0.8
            layer.shadowRadius = 10
            
            UIView.animateWithDuration(0.2) {
                self.transform = CGAffineTransformMakeScale(1.07,1.0)
            }
            
        } else {
            layer.shadowColor = UIColor.clearColor().CGColor
            
            UIView.animateWithDuration(0.2) {
                self.transform = CGAffineTransformMakeScale(1.0,1.0)
            }
        }
    }

    func configureCell(match: Match) {
        
        if match.opponents.count == 2 {
            let opponentA = match.opponents[0]
            let opponentB = match.opponents[1]

            if let participantA = opponentA.participantName, scoreA = opponentA.score {
                teamALabel.text = participantA
                teamAScoreLabel.text = "\(scoreA)"
            }
            
            if let participantB = opponentB.participantName, scoreB = opponentB.score {
                teamBLabel.text = participantB
                teamBScoreLabel.text = "\(scoreB)"
            }
            
            teamABackView.backgroundColor = UIColor.eSports_LogoBlue()
            teamALabel.textColor = UIColor.whiteColor()
            teamAScoreLabel.textColor = UIColor.whiteColor()

            teamBBackView.backgroundColor = UIColor.eSports_LogoRed()
            teamBLabel.textColor = UIColor.eSports_LogoYellow()
            teamBScoreLabel.textColor = UIColor.eSports_LogoYellow()
        }
    }
}
