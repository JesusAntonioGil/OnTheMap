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
        let target = URLProvider(endpoint: endpoint)
        
        let request = NSMutableURLRequest(URL: urlWithParams(target.url, parameters: target.paramenters))
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = httpBody(target.body)
        request.HTTPMethod = target.method
        
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
    
    //MARK: PRIVATE
    
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
