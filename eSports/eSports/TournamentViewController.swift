//
//  TournamentViewController.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/10/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class TournamentViewController: UIViewController {

    let toornamentClient = ToornamentController()
    var tournaments = [Tournament]()
    var matchs = [Match]()
    var games = [Game]()
    var discipline: Discipline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let discipline = discipline {
            toornamentClient.getTournaments(discipline.id, beforeStart: "2016-06-08", sort: "date_desc") { result in
                if let tournaments = result.value {
                    self.tournaments = tournaments
                }
                self.tournaments.forEach { t in
                    print("\(t.id) -- \(t.name)")
                }
            }
        }
        
        // match id astralis x NRG = 5733266170cb4913198b4570
        
//        toornamentClient.getMatchesByTournament("5733261f150ba005238b4567", hasResult: true, sort: "latest") { result in
//            if let matchs = result.value {
//                self.matchs = matchs
//            }
//            self.matchs.forEach { m in
//                print("\(m.opponents[0].participantName) vs \(m.opponents[1].participantName)")
//                print("\(m.games[0].map)")
//                print("\(m.id)")
//            }
//        }
        
        
        toornamentClient.getGamesByMatch(tournamentId: "5733261f150ba005238b4567", matchId: "5733266170cb4913198b4570") { result in
            if let games = result.value {
                self.games = games
            }
            self.games.forEach { t in
                print("\(t.opponents[0].participantName) -- \(t.opponents[0].lineup[0].name)")
            }
        }
    }
}
