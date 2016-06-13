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
    var discipline: Discipline?
    var participants = [Participant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let discipline = discipline {
            toornamentClient.getTournaments(discipline.id, beforeStart: "2016-05-08", sort: "date_desc") { result in
                if let tournaments = result.value {
                    self.tournaments = tournaments
                }
                self.tournaments.forEach { t in
                    print("\(t.id) -- \(t.name)")
                }
            }
        }
        
        // match id astralis x NRG = 5733266170cb4913198b4570
        //match id lg x splyce = 569f970c150ba039518b4583
                
        // dreamhack austin = 569f96a9140ba0be3a8b4568 , eleague group c = 5733261f150ba005238b4567
        
        toornamentClient.getParticipantsByTournament("569f96a9140ba0be3a8b4568") { result in
            
            if let participants = result.value {
                self.participants = participants
            }
            self.participants.forEach { p in
                
                print("\(p.name) ---- \(p.country)")
                p.lineup?.forEach { l in
                    print(l.name)
                }
            }
        }
    }
}
