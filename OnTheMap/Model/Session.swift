//
//  Session.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


final class Session: NSObject {

    var idSession: String!
    var expiration: NSDate!
}


extension Session: Mappable {
    
    convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        idSession <- map["id"]
        expiration <- map["expiration"]
    }
    
    //MARK: Custom String Convertible
    
    override var description: String {
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}


class SessionTransform: TransformType {
    
    typealias Object = Session
    typealias JSON = String
    
    init() { }
    
    func transformFromJSON(value: AnyObject?) -> Session? {
        
        guard value != nil else {
            return nil
        }
        return Mapper<Session>().map(value)
    }
    
    func transformToJSON(value: Session?) -> JSON? {
        guard value != nil else {
            return nil
        }
        return Mapper().toJSONString(value!, prettyPrint: true)!
    }
    
}