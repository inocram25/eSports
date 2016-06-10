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
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let game = game {
            print(game.id)
            toornamentClient.getTournaments(game.id, beforeStart: "2016-06-09", sort: "date_desc") { result in
                if let tournaments = result.value {
                    self.tournaments = tournaments
                }
                self.tournaments.forEach { t in
                    print("\(t.id) -- \(t.name)")
                }
            }
        }
        
//        toornamentClient.getMatchesByTournament("5733261f150ba005238b4567", hasResult: true, sort: "latest") { result in
//            if let matchs = result.value {
//                self.matchs = matchs
//            }
//            self.tournaments.forEach { m in
//                print("\(m.id) -- \(m.status)")
//            }
//        }
    }
}
