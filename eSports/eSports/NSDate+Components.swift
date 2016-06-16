//
//  NSDate+Diff.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 5/9/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

extension NSDate {
    
    var toString: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return dateFormatter.stringFromDate(self)
    }
    
    var day: String {
        return "\(getComponentForUnit(.Day))"
    }
    var month: String {
        return getComponentForUnit(.Month) < 10 ? ("0\(getComponentForUnit(.Month))") : "\(getComponentForUnit(.Month))"
    }
    
    var year: String {
        return "\(getComponentForUnit(.Year))"
    }
    
    func getComponentForUnit(unit: NSCalendarUnit) -> Int {
        return NSCalendar.currentCalendar().component(unit, fromDate: self)
    }

}
