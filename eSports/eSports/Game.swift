//
//  Game.swift
//  eSports
//
//  Created by guilherme babugia on 12/06/16.
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
    
    let lineups: [Lineup]?
}

struct Game {
    let number: Int
    let status: String
    let map: String?
    let opponents: [Opponent]
}

struct Lineup {
    let name: String
    let kills: Int
    let deaths: Int
    let assists: Int
    let kd: Float
    
}

extension Game: Decodable {
    static func decode(json: JSON) -> Game? {
        return json.game
    }
}

extension JSON {
    
    var lineup: Lineup? {
        let name = self["name"].string
        let kills = self["kills"].int
        let deaths = self["deaths"].int
        let assists = self["assists"].int
        let kd = self["kills_per_deaths"].float
        
        return Lineup(name: name!, kills: kills!, deaths: deaths!, assists: assists!, kd: kd!)
    }
    
    var opponent: Opponent? {
        
        let result = self["result"].int
        let score = self["score"].int
        let forfeit = self["forfeit"].bool
        let participantId = self["participant"]["id"].string
        let participantName = self["participant"]["name"].string
        let participantCountry = self["participant"]["country"].string
        let lineups = self["lineup"].arrayValue.flatMap { $0.lineup }
        
        return Opponent(result: result, score: score, forfeit: forfeit!, participantId: participantId, participantName: participantName, participantCountry: participantCountry, lineups: lineups)
    }
    
    var game: Game? {
        
        let number = self["number"].int
        let status = self["status"].string
        let map = self["map"].string
        let opponents = self["opponents"].arrayValue.flatMap { $0.opponent }
        
        return Game(number: number! , status: status!, map: map, opponents: opponents)
    }
}

