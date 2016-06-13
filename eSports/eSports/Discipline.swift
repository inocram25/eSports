//
//  Game.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/7/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import SwiftyJSON

struct Discipline {
    let id: String
    let name: String
    let shortname: String?
    let fullname: String?
    let copyrights: String?
}

extension Discipline: Decodable {
    static func decode(json: JSON) -> Discipline? {
        return json.discipline
    }
}

extension JSON {
    var discipline: Discipline? {
        
        let id = self["id"].string
        let name = self["name"].string
        let shortname = self["shortname"].string
        let fullname = self["fullname"].string
        let copyrights = self["copyrights"].string
        
        return Discipline(id: id!, name: name!, shortname: shortname, fullname: fullname, copyrights: copyrights)
    }
}