//
//  WeekDay.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/22/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

enum WeekDay: Int {
    
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    
    var description: String {
        switch self {
        case .Sunday:
            return "Sun"
        case .Monday:
            return "Mon"
        case .Tuesday:
            return "Tue"
        case .Wednesday:
            return "Wed"
        case .Thursday:
            return "Thu"
        case .Friday:
            return "Fri"
        case .Saturday:
            return "Sat"
        
        }
    }
}
