//
//  MatchViewController.swift
//  eSports
//
//  Created by guilherme babugia on 13/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    let toornamentClient = ToornamentController()
    var matchs = [Match]()
    var tournament: Tournament?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toornamentClient.getMatchesByTournament("569f96a9140ba0be3a8b4568", hasResult: true, sort: "latest") { result in
            if let matchs = result.value {
                self.matchs = matchs
            }
            self.matchs.forEach { m in
                print("\(m.opponents[0].participantName) vs \(m.opponents[1].participantName)")
                print("\(m.games[0].map)")
                print("\(m.id)")
            }
        }

    }
}
