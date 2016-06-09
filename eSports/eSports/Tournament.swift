//
//  Tournament.swift
//  eSports
//
//  Created by guilherme babugia on 09/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import SwiftyJSON

struct Tournament {
    
    let id: String
    let discipline: String
    let name: String
    let fullName: String?
    let status: String
    let dateStart: String?
    let dateEnd: String?
    let isOnline: Bool
    let isPublic: Bool
    let location: String?
    let country: String?
    let size: Int
    
}

extension Tournament: Decodable {
    static func decode(json: JSON) -> Tournament? {
        return json.tournament
    }
}

extension JSON {
    var tournament: Tournament? {
        
        let id = self["id"].string
        let discipline = self["discipline"].string
        let name = self["name"].string
        let fullName = self["full_name"].string
        let status = self["status"].string
        let dateStart = self["date_start"].string
        let dateEnd = self["date_end"].string
        let isOnline = self["online"].bool
        let isPublic = self["public"].bool
        let location = self["location"].string
        let country = self["country"].string
        let size = self["size"].int
        
        return Tournament(id: id!, discipline: discipline!, name: name!, fullName: fullName, status: status!, dateStart: dateStart, dateEnd: dateEnd, isOnline: isOnline!, isPublic: isPublic!, location: location, country: country, size: size!)
    }
}