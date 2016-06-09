//
//  Decodable.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/9/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Decodable {
    static func decode(json: JSON) -> Self?
}