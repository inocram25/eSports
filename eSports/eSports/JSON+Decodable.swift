//
//  JSON+Decodable.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/9/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import SwiftyJSON

extension JSON {
    func decode<T: Decodable>() -> T? {
        return T.decode(self)
    }
    
    func decode<T: Decodable>() -> [T] {
        return self.arrayValue.flatMap { T.decode($0) }
    }
}
