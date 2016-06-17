//
//  MatchCell.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/16/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {
    
    @IBOutlet weak var teamALogoImageView: UIImageView!
    @IBOutlet weak var teamALabel: UILabel!
    @IBOutlet weak var teamAScoreLabel: UILabel!


    @IBOutlet weak var teamBLogoImageView: UIImageView!
    @IBOutlet weak var teamBLabel: UILabel!
    @IBOutlet weak var teamBScoreLabel: UILabel!
    
    @IBOutlet weak var teamABackView: TrapeziumView!
    @IBOutlet weak var teamBBackView: ReverseTrapeziumView!
    

    //test
    let logoTest = ["biggods", "cnb", "pain-gaming", "intz", "keyd", "red-canids"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
            
        let opponentA = match.opponents[0]
        let opponentB = match.opponents[1]
        
        teamALogoImageView.image = UIImage(named: logoTest[Int(arc4random() % 6)])
        teamBLogoImageView.image = UIImage(named: logoTest[Int(arc4random() % 6)])

        if let participantA = opponentA.participantName, scoreA = opponentA.score {
            teamALabel.text = participantA
            teamAScoreLabel.text = "\(scoreA)"
        }
        
        if let participantB = opponentB.participantName, scoreB = opponentB.score {
            teamBLabel.text = participantB
            teamBScoreLabel.text = "\(scoreB)"
        }
        
        teamALogoImageView.image?.getColors { colors in
            self.teamABackView.backgroundColor = colors.backgroundColor
            self.teamALabel.textColor = colors.primaryColor
            self.teamAScoreLabel.textColor = colors.secondaryColor
        }

        teamBLogoImageView.image?.getColors { colors in
            self.teamBBackView.backgroundColor = colors.backgroundColor
            self.teamBLabel.textColor = colors.primaryColor
            self.teamBScoreLabel.textColor = colors.secondaryColor
        }
        
    }

}
