//
//  Region.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/14/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

enum Region: Int {
    case Africa
    case NorthAmerica
    case SouthAmerica
    case Oceania
    case Europe
    case Asia
}

extension Region: CustomStringConvertible {
    var description: String {
        switch self {
        case .Africa:
            return "Africa"
        case .SouthAmerica:
            return "South America"
        case .Oceania:
            return "Oceania"
        case .Europe:
            return "Europe"
        case .Asia:
            return "Asia"
        case .NorthAmerica:
            return "North America"
            
        }
    }
    
    var image: UIImage {
        switch self {
        case .Africa:
            return UIImage(named:"AF")!
        case .SouthAmerica:
            return UIImage(named:"SA")!
        case .Oceania:
            return UIImage(named:"OC")!
        case .Europe:
            return UIImage(named:"EU")!
        case .Asia:
            return UIImage(named:"AS")!
        case .NorthAmerica:
            return UIImage(named:"NA")!
        }
    }
}