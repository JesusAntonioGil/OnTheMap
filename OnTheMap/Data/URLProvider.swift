//
//  URLProvider.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit

private let kUdacityHost = "https://www.udacity.com/api"


class URLProvider: NSObject {

    var urlEndpoint: URLEndpoint
    
    
    //MARK: LIFE CYCLE
    
    init(endpoint: URLEndpoint) {
        self.urlEndpoint = endpoint
    }
    
    
    //MARK: PUBLIC
    
    var url: NSURL {
        get {
            switch urlEndpoint {
                case .Login(_):     return urlWithEndpoint("/session")
                case .Logout():     return urlWithEndpoint("/session")
            }
        }
    }
    
    var paramenters: [String]! {
        get {
            switch urlEndpoint {
                case .Login(_):     return nil
                case .Logout():     return nil
            }
        }
    }
    
    var body: String! {
        get {
            switch urlEndpoint {
                case .Login(let loginDTO):      return loginDTO.parameters
                case .Logout():                 return nil
            }
        }
    }
    
    var method: String {
        get {
            switch urlEndpoint {
                case .Login(_):     return "POST"
                case .Logout():     return "DELETE"
            }
        }
    }
    
    
    //MARK: PRIVATE
    
    private func urlWithEndpoint(endpoint: String) -> NSURL {
        let urlString = String(format: "%@%@", arguments: [kUdacityHost, endpoint])
        return NSURL(string: urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
    }
    
}
