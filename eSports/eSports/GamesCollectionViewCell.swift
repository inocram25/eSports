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
    
    
    override func awakeFromNib() {
        
        title.text = "Counter-Strike: Global Offensive"
        imageView.image = UIImage(named: "csgo-menu")
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
    }
    
    
//    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
//        if (context.nextFocusedView == self) {
//            
//        } else {
//            
//        }
//    }
    
    func configureCell(game: Game) {
        imageView.image = UIImage(named: "csgo-menu")
        title.text = game.name
    }
}
