//
//  GamesViewController.swift
//  eSports
//
//  Created by guilherme babugia on 13/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    
    let toornamentClient = ToornamentController()
    var games = [Game]()
    var match: Match?
    var tournament: Tournament?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        toornamentClient.getGamesByMatch(tournamentId: "5733261f150ba005238b4567", matchId: "5733266170cb4913198b457c") { result in
            if let games = result.value {
                self.games = games
            }
            self.games.forEach { t in
                print("\(t.opponents[0].participantName) ----- ")
            }
        }
    }

}
