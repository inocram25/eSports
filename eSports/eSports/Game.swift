//
//  Game.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/7/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import SwiftyJSON

struct Game {
    let id: String
    let name: String
    let shortname: String?
    let fullname: String?
    let copyrights: String?
}

extension Game: Decodable {
    static func decode(json: JSON) -> Game? {
        return json.game
    }
}

extension JSON {
    var game: Game? {
        
        let id = self["id"].string
        let name = self["name"].string
        let shortname = self["shortname"].string
        let fullname = self["fullname"].string
        let copyrights = self["copyrights"].string
        
        return Game(id: id!, name: name!, shortname: shortname, fullname: fullname, copyrights: copyrights)
    }
}