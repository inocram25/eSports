//
//  GamesCollectionViewCell.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/7/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var currentGame: Discipline?
    
    override func awakeFromNib() {
        imageView.adjustsImageWhenAncestorFocused = true
    }
    
    func configureCell(discipline: Discipline) {
        currentGame = discipline
        
        imageView.image = discipline.image
    }
}
