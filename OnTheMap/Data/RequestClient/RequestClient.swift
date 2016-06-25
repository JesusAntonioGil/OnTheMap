//
//  RequestClient.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol RequestClientDelegate {
    func requestClientSuccess(data: AnyObject)
    func requestClientError(error: NSError)
}


class RequestClient: NSObject {
    
    var delegate: RequestClientDelegate?
    
    
    //MARK: PUBLIC
    
    func request(endpoint: URLEndpoint) {
        switch endpoint {
            case .Login(_), .Logout():
                requestUdacity(endpoint)
            case .StudentLocations(), .UpdateStudentLocetion(_):
                requestParse(endpoint)
        }
    }
    
    //MARK: PRIVATE
    
    private func requestUdacity(endpoint: URLEndpoint) {
        let target = URLProvider(endpoint: endpoint)
        
        let request = NSMutableURLRequest(URL: urlWithParams(target.url, parameters: target.paramenters))
        request.HTTPMethod = target.method
        if(target.method != "DELETE") {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = httpBody(target.body)
        } else {
            let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
            var xsrfCookie: NSHTTPCookie? = nil
            for cookie in sharedCookieStorage.cookies! {
                if cookie.name == "XSRF-TOKEN" {
                    xsrfCookie = cookie
                }
            }
            if let xsrfCookie = xsrfCookie {
                request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            }
        }
        
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            if(error != nil) {
                self.delegate?.requestClientError(error!)
                return
            }
            
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            do {
                let jsonDict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments) as! NSDictionary
                if (jsonDict.valueForKey("error") != nil) {
                    self.delegate?.requestClientError(NSError(domain: "OnTheMap", code: jsonDict.valueForKey("status") as! NSInteger, userInfo: [NSLocalizedDescriptionKey: jsonDict.valueForKey("error")!]))
                } else {
                    self.delegate?.requestClientSuccess(jsonDict)
                }
            } catch {
                self.delegate?.requestClientError(NSError(domain: "OnTheMap", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error read json"]))
            }
            
        }
        task.resume()
    }
    
    private func requestParse(endpoint: URLEndpoint) {
        let target = URLProvider(endpoint: endpoint)
        let request = NSMutableURLRequest(URL: urlWithParams(target.url, parameters: target.paramenters))
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = target.method
        
        if(target.method == "PUT") {
            request.HTTPBody = httpBody(target.body)
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if (error != nil) {
                self.delegate?.requestClientError(error!)
                return
            }
    
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            do {
                let jsonDict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                if (jsonDict.valueForKey("error") != nil) {
                    self.delegate?.requestClientError(NSError(domain: "OnTheMap", code: 900 , userInfo: [NSLocalizedDescriptionKey: jsonDict.valueForKey("error")!]))
                } else {
                    self.delegate?.requestClientSuccess(jsonDict)
                }
            } catch {
                self.delegate?.requestClientError(NSError(domain: "OnTheMap", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error read json"]))
            }
            
        }
        task.resume()
    }
    
    private func urlWithParams(url: NSURL, parameters: [String]!) -> NSURL {
        var stringUrl = url.absoluteString
        
        if(parameters != nil) {
            for param in parameters {
                stringUrl = stringUrl.stringByAppendingString("/\(param)")
            }
        }
        
        return NSURL(string: stringUrl)!
    }
    
    private func httpBody(body: String!) -> NSData? {
        if(body != nil) {
            return body.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        return nil
    }
    
}
