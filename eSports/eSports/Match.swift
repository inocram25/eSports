//
//  Match.swift
//  eSports
//
//  Created by guilherme babugia on 09/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Opponent {
    //1 = win, 2 = draw, 3 = loss.
    let result: Int?
    let score: Int?
    let forfeit: Bool
    
    //Paticipant
    let participantId: String?
    let participantName: String?
    let participantCountry: String?
}

struct Games {
    let number: Int
    let status: String
    let map: String?
    let opponents: [Opponent]
}

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
    let games : [Games]
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
        let games = self["games"].arrayValue.flatMap { $0.games }
        
        return Match(id: id!, discipline: discipline!, status: status!, tournamentID: tournamentId!, stage: stage!, group: group!, round: round!, date: date, timezone: timezone, matchFormat: matchFormat, opponents: opponents, games: games)
    }
    
    var opponent: Opponent? {
        
        let result = self["result"].int
        let score = self["score"].int
        let forfeit = self["forfeit"].bool
        let participantId = self["participant"]["id"].string
        let participantName = self["participant"]["name"].string
        let participantCountry = self["participant"]["country"].string
        
        return Opponent(result: result, score: score, forfeit: forfeit!, participantId: participantId, participantName: participantName, participantCountry: participantCountry)
    }
    
    var games: Games? {
        
        let number = self["number"].int
        let status = self["status"].string
        let map = self["map"].string
        let opponents = self["opponents"].arrayValue.flatMap { $0.opponent }
        
        return Games(number: number! , status: status!, map: map, opponents: opponents)
    }
}