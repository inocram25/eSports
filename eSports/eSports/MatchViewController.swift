//
//  MatchViewController.swift
//  eSports
//
//  Created by guilherme babugia on 13/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    private let toornamentClient = ToornamentController()
    var matchs = [Match]()
    var tournament: Tournament?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // match id astralis x NRG = 5733266170cb4913198b4570
        //match id lg x splyce = 569f970c150ba039518b4583
        
        // dreamhack austin = 569f96a9140ba0be3a8b4568 ,
        //        eleague group c = 5733261f150ba005238b4567
        // ESL Cologne = 5668664d150ba0d80a8b45ed
        
        //        toornamentClient.getParticipantsByTournament("5668664d150ba0d80a8b45ed") { result in
        //
        //            if let participants = result.value {
        //                self.participants = participants
        //            }
        //            self.participants.forEach { p in
        //
        //                print("\(p.name) ---- \(p.country)")
        //                p.lineup?.forEach { l in
        //                    print(l.name)
        //                }
        //            }
        //        }
        
        if let id = tournament?.id {
            toornamentClient.getMatchesByTournament(id, hasResult: true, sort: "latest") { result in
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
}
