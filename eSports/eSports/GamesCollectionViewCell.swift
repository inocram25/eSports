//
//  GamesCollectionViewCell.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/7/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var currentGame: Discipline?
    
    
    override func awakeFromNib() {
        
        title.text = "Counter-Strike: Global Offensive"
        imageView.image = UIImage(named: "csgo-menu")
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
    }
    
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedView == self) {
            
            self.topConstraint.constant = 80
            UIView.animateWithDuration(0.3) {
                self.title.transform = CGAffineTransformMakeScale(1.4, 1.4)
                self.layoutIfNeeded()
            }
            
        } else {
            self.topConstraint.constant = 30
            UIView.animateWithDuration(0.3) {
                self.title.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.layoutIfNeeded()
            }

        }
    }
    
    func configureCell(discipline: Discipline) {
        currentGame = discipline
        
        imageView.image = UIImage(named: "csgo-menu")
        title.text = discipline.name
    }
}
