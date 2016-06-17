//
//  WeekDayCell.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/16/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class WeekDayCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
     var gradient: CAGradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradient.colors = [UIColor.eSports_DarkGray().CGColor, UIColor.eSports_LightGray().CGColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.frame
        
        layer.insertSublayer(gradient, atIndex: 0)
    }
    
    func configureCell(date: String) {
    
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if (context.nextFocusedView == self) {
            
            backgroundColor = UIColor.clearColor()
            
            layer.shadowColor = UIColor.eSports_LightBlue().CGColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.8
            layer.shadowRadius = 10
            
            gradient.removeFromSuperlayer()
            
            gradient.colors = [UIColor.eSports_Black().CGColor, UIColor.eSports_DarkGray().CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = self.bounds
            
            layer.insertSublayer(gradient, atIndex: 0)
            
            
            UIView.animateWithDuration(0.2) {
                self.transform = CGAffineTransformMakeScale(1.05,1.0)
            }
            
        } else {
            backgroundColor = UIColor.clearColor()
            layer.shadowColor = UIColor.clearColor().CGColor
            
            gradient.removeFromSuperlayer()
            
            gradient.colors = [UIColor.eSports_DarkGray().CGColor, UIColor.eSports_LightGray().CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = self.bounds
            
            layer.insertSublayer(gradient, atIndex: 0)
            
            
            UIView.animateWithDuration(0.2) {
                self.transform = CGAffineTransformMakeScale(1.0,1.0)
            }
        }
    }
}