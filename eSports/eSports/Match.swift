//
//  Match.swift
//  eSports
//
//  Created by guilherme babugia on 09/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation

struct Opponent {
    let number: Int
    let participant: Participant
    let result: Int?
    let rank: Int?
    let score: Int?
    let forfeit: Bool
}

struct Participant {
    let id: String
    let name: String
    let country: String?
}

struct Games {
    let number: Int
    let status: String
    let opponents: [Opponent]
}

struct Match {
    
    let id: String
    let type: String
    let discipline: String
    let status: String
    let tournamentID :String
    let number: Int
    let stage_number: Int
    let group_number: Int
    let date: String?
    let timezone: String?
    let matchFormat: String?
    let opponents: [Opponent]
    let games : [Games]
    
}