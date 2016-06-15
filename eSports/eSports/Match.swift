//
//  Match.swift
//  eSports
//
//  Created by guilherme babugia on 09/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Match {
    
    let id: String
    let discipline: String
    let status: String
    let tournamentID :String
    let stage: Int
    let group: Int
    let round: Int
    let date: String?
    let timezone: String?
    let matchFormat: String?
    let opponents: [Opponent]
    let games : [Game]
}

extension Match: Decodable {
    static func decode(json: JSON) -> Match? {
        return json.match
    }
}

extension JSON {
    var match: Match? {
        
        let id = self["id"].string
        let discipline = self["discipline"].string
        let status = self["status"].string
        let tournamentId = self["tournament_id"].string
        let stage = self["stage_number"].int
        let group = self["group_number"].int
        let round = self["round_number"].int
        let date = self["date"].string
        let timezone = self["timezone"].string
        let matchFormat = self["match_format"].string
        let opponents = self["opponents"].arrayValue.flatMap { $0.opponent }
        let game = self["games"].arrayValue.flatMap { $0.game }
        
        return Match(id: id!, discipline: discipline!, status: status!, tournamentID: tournamentId!, stage: stage!, group: group!, round: round!, date: date, timezone: timezone, matchFormat: matchFormat, opponents: opponents, games: game)
    }
}