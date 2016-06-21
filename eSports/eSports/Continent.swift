//
//  Continent.swift
//  eSports
//
//  Created by guilherme babugia on 20/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import SwiftyJSON

struct Continent {
    var country: String
    var continent:String
}

extension Continent: Decodable {
    static func decode(json: JSON) -> Continent? {
        return json.continent
    }
}

extension JSON {
    var continent: Continent? {
        
        let country = self["country"].string
        let continent = self["continent"].string
        
        return Continent(country: country!, continent: continent!)
    }
}