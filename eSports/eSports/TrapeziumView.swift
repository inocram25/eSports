//
//  TrapeziumView.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/14/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class TrapeziumView: UIView {
    override func drawRect(rect: CGRect) {
        
        // Get Height and Width
        let layerHeight = self.layer.frame.height
        let layerWidth = self.layer.frame.width
        
        // Create Path
        let bezierPath = UIBezierPath()
        
        // Draw Points
        bezierPath.moveToPoint(CGPoint(x: 0, y: 0))
        bezierPath.addLineToPoint(CGPoint(x: 0, y: layerHeight))
        bezierPath.addLineToPoint(CGPoint(x: layerWidth, y: layerHeight))
        bezierPath.addLineToPoint(CGPoint(x: 0.8*layerWidth , y: 0))

        bezierPath.closePath()
        
        // Apply Color
        UIColor.clearColor().setFill()
        bezierPath.fill()
        
        // Mask to Path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.CGPath
        self.layer.mask = shapeLayer
        
    }
}