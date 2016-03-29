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
            self.delegate?.requestClientSuccess(newData)
        }
        task.resume()
    }
    
    //MARK: PRIVATE
    
    private func urlWithParams(url: NSURL, parameters: [String]!) -> NSURL {
        var stringUrl = url.absoluteString
        for param in parameters {
            //stringUrl.append("/\(param)")
        }
        return NSURL(string: stringUrl)!
    }
    
    private func httpBody(body: [String: AnyObject]!) -> NSData? {
        return body.description.dataUsingEncoding(NSUTF8StringEncoding)
    }
    
}
