//
//  DataManager.swift
//  eSports
//
//  Created by guilherme babugia on 20/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

public class DataManager {
    
    public class func getDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource("Countries+Continents", ofType:"json")
            let data = try! NSData(contentsOfFile:filePath!,
                options: NSDataReadingOptions.DataReadingUncached)
            success(data: data)
        })
    }
    
}
