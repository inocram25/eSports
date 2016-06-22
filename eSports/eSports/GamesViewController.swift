//
//  GamesViewController.swift
//  eSports
//
//  Created by guilherme babugia on 13/06/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit


private let LeftTableReuseIdentifier = "leftTable"
private let RightTableReuseIdentifier = "rightTable"
private let ResultTableReuseIdentifier = "gameResultCell"

enum gameResult: Int {
    case win = 1
    case draw = 2
    case loose = 3
    
    var description: String {
        switch self {
        case .win:
            return "Win"
        case .draw:
            return "Draw"
        case .loose:
            return "Loss"
        }
    }
    
    var color: UIColor {
        switch self {
        case .win:
            return UIColor.eSports_Green()
        case .draw:
            return UIColor.yellowColor()
        case .loose:
            return UIColor.redColor()
        }
    }
}


class GamesViewController: UIViewController {
    
    private let toornamentClient = ToornamentController()
    private var games = [Game]()
    private var participants = [Participant]()
    
    var match: Match?

    
    @IBOutlet private weak var tableViewLeft: UITableView!
    @IBOutlet private weak var tableViewRight: UITableView!
    @IBOutlet private weak var tableViewMiddle: UITableView!
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var headerView: UIView!
    
    //Team A
    @IBOutlet private weak var leftBackView: TrapeziumView!
    @IBOutlet private weak var leftLogoImageView: UIImageView!
    @IBOutlet private weak var leftTeamLabel: UILabel!
    
    var lineupA = [Lineup]()
    
    //Team B
    @IBOutlet private weak var rightBackView: ReverseTrapeziumView!
    @IBOutlet private weak var rightLogoImageView: UIImageView!
    @IBOutlet private weak var rightTeamLabel: UILabel!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    
    var lineupB = [Lineup]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = UIColor.eSports_DarkBlue()
        activityIndicator.layer.hidden = false
        activityIndicator.startAnimating()
        
        if let match = match {
         
            configureHeader()
            
            let group = dispatch_group_create()
            
            dispatch_group_enter(group)
            toornamentClient.getGamesByMatch(tournamentId: match.tournamentID, matchId: match.id) { [weak self] result in
                if let games = result.value {
                    
                    games.forEach { game in
                        if game.status != "pending" {
                            self?.games.append(game)
                        }
                    }
                    
                }
                dispatch_group_leave(group)
            }
            
            //Games lineup not working (API Beta), then we need to find lineup using other API request and compare the participant id.
            dispatch_group_notify(group, dispatch_get_main_queue()) { [weak self] in
                self?.toornamentClient.getParticipantsByTournament(match.tournamentID) { result in
                    
                    if let participants = result.value {
                        self?.participants = participants
                    }
                    
                    self?.participants.forEach { p in
                        
                        if p.id == self?.games[0].opponents[0].participantId {
                            guard let lineup = p.lineup else { return }
                            self?.lineupA = lineup
                        }
                        
                        if p.id == self?.games[0].opponents[1].participantId {
                            guard let lineup = p.lineup else { return }
                            self?.lineupB = lineup
                        }
                        
                    }
                    
                    self?.tableViewLeft.reloadData()
                    self?.tableViewRight.reloadData()
                    self?.tableViewMiddle.reloadData()
                    self?.activityIndicator.layer.hidden = true
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func configureHeader() {
        
        headerView.backgroundColor = UIColor.redColor()
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.eSports_HeaderBlue().CGColor, UIColor.eSports_Black().CGColor, UIColor.eSports_DarkRed().CGColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = headerView.frame
        
        headerView.layer.insertSublayer(gradient, atIndex: 0)
        
        guard let match = match else { return }
        
        if let date = match.date {
            if let dateFormatted = NSDate.dateFromISOString(date) {
                let weekday = WeekDay(rawValue: dateFormatted.weekDay)!.description
                dateLabel.text = "\(weekday) \(dateFormatted.month)/\(dateFormatted.day)"
                hourLabel.text = "\(dateFormatted.hour):\(dateFormatted.minute)"
            }
        }
            
        leftTeamLabel.text = match.opponents[0].participantName
        rightTeamLabel.text = match.opponents[1].participantName
        
        leftTeamLabel.numberOfLines = 1
        leftTeamLabel.minimumScaleFactor = (20.0 / leftTeamLabel.font.pointSize)
        leftTeamLabel.adjustsFontSizeToFitWidth = true
        leftTeamLabel.textColor = UIColor.whiteColor()
        leftBackView.backgroundColor = UIColor.eSports_LogoBlue()
        
        rightTeamLabel.numberOfLines = 1
        rightTeamLabel.minimumScaleFactor = (20.0 / leftTeamLabel.font.pointSize)
        rightTeamLabel.adjustsFontSizeToFitWidth = true
        rightTeamLabel.textColor = UIColor.eSports_LogoYellow()
        rightBackView.backgroundColor = UIColor.eSports_LogoRed()
    }
}

extension GamesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == tableViewLeft || tableView == tableViewRight ? lineupA.count : games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == tableViewLeft {
            let cell = tableView.dequeueReusableCellWithIdentifier(LeftTableReuseIdentifier) as? ParticipantACell
            cell?.configureCell(lineupA[indexPath.row])
            return cell!

        }
        else if tableView == tableViewRight {
            let cell = tableView.dequeueReusableCellWithIdentifier(RightTableReuseIdentifier) as? ParticipantBCell
            cell?.configureCell(lineupB[indexPath.row])
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier(ResultTableReuseIdentifier) as? GameResultCell
            cell?.configureCell(games[indexPath.row])
            return cell!
        }
    }
    
}
