//
//  Account.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


final class Account: NSObject {

    var registered: Bool!
    var key: String!
}


extension Account: Mappable {
    
    convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        registered <- map["registered"]
        key <- map["key"]
    }
    
    //MARK: Custom String Convertible
    
    override var description: String {
        return Mapper().toJSONString(self, prettyPrint: true)!
    }

}


class AccountTransform: TransformType {
    
    typealias Object = Account
    typealias JSON = String
    
    init() { }
    
    func transformFromJSON(value: AnyObject?) -> Account? {
        
        guard value != nil else {
            return nil
        }
        return Mapper<Account>().map(value)
    }
    
    func transformToJSON(value: Account?) -> JSON? {
        guard value != nil else {
            return nil
        }
        return Mapper().toJSONString(value!, prettyPrint: true)!
    }
    
}