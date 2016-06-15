//
//  Participant.swift
//  eSports
//
//  Created by guilherme babugia on 13/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Participant {
    
    let id: String
    let name: String
    let iconExtraSmall: NSURL?
    let iconSmall: NSURL?
    let iconMedium: NSURL?
    let iconLarge: NSURL?
    let country: String?
    let lineup: [Lineup]?
    
}

extension Participant: Decodable {
    static func decode(json: JSON) -> Participant? {
        return json.participant
    }
}

extension JSON {
    
    var participant: Participant? {
        let id = self["id"].string
        let name = self["name"].string
        let iconExtraSmall = self["icon_large_square"].URL
        let iconSmall = self["extra_small_square"].URL
        let iconMedium = self["medium_small_square"].URL
        let iconLarge = self["medium_large_square"].URL
        let country = self["country"].string
        let lineup = self["lineup"].arrayValue.flatMap { $0.lineup }
        
        return Participant(id: id!, name: name!, iconExtraSmall: iconExtraSmall, iconSmall: iconSmall, iconMedium: iconMedium, iconLarge: iconLarge, country: country, lineup: lineup)
    }
    
}

