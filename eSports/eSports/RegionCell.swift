//
//  RegionCell.swift
//  eSports
//
//  Created by guilherme babugia on 13/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class RegionCell: UITableViewCell {
    
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var backView: TrapeziumView!
    
    var gradient: CAGradientLayer = CAGradientLayer()

    
    override func awakeFromNib() {

            gradient.colors = [UIColor.eSports_DarkGray().colorWithAlphaComponent(0.5).CGColor, UIColor.eSports_LightGray().colorWithAlphaComponent(0.7).CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = backView.frame

            backView.layer.insertSublayer(gradient, atIndex: 0)

    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if (context.nextFocusedView == self) {
            
            backgroundColor = UIColor.clearColor()
            layer.shadowColor = UIColor.eSports_LightBlue().CGColor
            layer.shadowOffset = CGSize(width: 0, height: 5)
            layer.shadowOpacity = 0.8
            layer.shadowRadius = 30
            
            gradient.removeFromSuperlayer()
            
            gradient.colors = [UIColor.eSports_Black().colorWithAlphaComponent(0.5).CGColor, UIColor.eSports_DarkBlue().colorWithAlphaComponent(1.0).CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = backView.frame
            
            backView.layer.insertSublayer(gradient, atIndex: 0)
            
            
            UIView.animateWithDuration(0.2) {
                self.transform = CGAffineTransformMakeScale(1.1,1.0)
            }
            
        } else {
            backgroundColor = UIColor.clearColor()
            layer.shadowColor = UIColor.clearColor().CGColor
            
            gradient.removeFromSuperlayer()
            
            gradient.colors = [UIColor.eSports_DarkGray().colorWithAlphaComponent(0.5).CGColor, UIColor.eSports_LightGray().colorWithAlphaComponent(0.7).CGColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = backView.frame
            
            backView.layer.insertSublayer(gradient, atIndex: 0)
            
            
            UIView.animateWithDuration(0.2) {
                self.transform = CGAffineTransformMakeScale(1.0,1.0)
            }
        }
    }

}