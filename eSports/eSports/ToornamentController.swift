//
//  ToornamentController.swift
//  eSports
//
//  Created by Alexandre Calil Marconi on 6/9/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ToornamentController {
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-type"] = "application/json"
            headers["X-Api-Key"] = "e3O6LMSzkymzoYqwuKUGb6yexX9qmnMWDtB1-OqHLUk"
            
            configuration.HTTPAdditionalHeaders = headers
            return configuration
        }()
        
        return Manager(configuration: configuration)
    }()
    
    
    func getGames(completion: Result<[Game], NSError> -> Void) {
        let router = Router.allGames
        getDecodableObject(router, completion: completion)
    }
    
    
//    func getTournaments(gameID: String, beforeStart: String, sort: String, completion: Result<[String], NSError> -> Void) {
//        let router = Router.allTournamentsGame(gameID, beforeStart, sort)
//        getDecodableObject(router, completion: completion)
//    }
    
    private func getDecodableObject<T: Decodable>
        (router: Router, completion: Result<[T], NSError> -> Void)
    {
        manager.request(router).validate().responseJSON { response in
            
            guard let value = response.result.value else {
                completion(Result.Failure(response.result.error!)); return
            }
            
            completion(Result.Success(JSON(value).decode()))
        }
    }
    
    private func getDecodableObject<T: Decodable>
        (router: Router, completion: Result<T, NSError> -> Void)
    {
        manager.request(router).validate().responseJSON { response in
            
            guard let value = response.result.value else {
                completion(Result.Failure(response.result.error!)); return
            }
            
            guard let object: T = JSON(value).decode() else {
                completion(Result.Failure(decodeFailureError())); return
            }
            
            completion(Result.Success(object))
        }
    }
}

private func decodeFailureError() -> NSError {
    return NSError(domain: "com.TraktTVController.DecodeFailure", code: 0, userInfo: nil)
}

private enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://api.toornament.com/v1/"
    
    case allGames
    
    //id = game id; before_start = 2016-12-30; sort = date_asc, date_desc;
    case allTournamentsGame(String,String,String)
    case tournamentInfo(String)
    
    var URLRequest: NSMutableURLRequest {
        let (path, parameters, method): (String, [String: AnyObject]?, Alamofire.Method) = {
            switch self {
                
            case .allGames:
                return ("disciplines", nil, .GET)
                
            case .allTournamentsGame(let id, let date, let sort):
                let parameters = ["discipline" : id, "before_start" : date, "sort" : sort]
                return ("tournaments", parameters, .GET)
                
            case .tournamentInfo(let id):
                let parameters = ["with_streams" : 1]
                return ("tournaments/\(id)", parameters, .GET)
                
            }
            
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(URLRequest, parameters: parameters).0
    }
}
