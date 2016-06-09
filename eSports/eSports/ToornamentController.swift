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
    
    
    func getPopularShows(completion: Result<[Show], NSError> -> Void) {
        let router = Router.popularShows
        getDecodableObject(router, completion: completion)
    }
    
    func getAllSeasonsForShow(id: String, completion: Result<[Season], NSError> -> Void) {
        let router = Router.seasonsForShow(id)
        getDecodableObject(router, completion: completion)
    }
    
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
    
    //id = game id; status = setup, running, completed; sort = date_asc, date_desc;
    case tournamentsGameOnStatus(String,String,String)
    
    var URLRequest: NSMutableURLRequest {
        let (path, parameters, method): (String, [String: AnyObject]?, Alamofire.Method) = {
            switch self {
                
            case .allGames:
                return ("disciplines", nil, .GET)
                
            case .tournamentsGameOnStatus(let id, let status, let sort):
                let parameters = ["discipline" : id, "status" : status, "sort" : sort]
                return ("tournaments", parameters, .GET)
                
            }
            
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(URLRequest, parameters: parameters).0
    }
}
