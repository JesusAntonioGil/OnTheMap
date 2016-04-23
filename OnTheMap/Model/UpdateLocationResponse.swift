//
//  UpdateLocationResponse.swift
//  OnTheMap
//
//  Created by Jesus Antonio Gil on 23/4/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


final class UpdateLocationResponse: NSObject {

    var updatedAt: String!
}


extension UpdateLocationResponse: Mappable {
    
    convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        updatedAt <- map["updatedAt"]
    }
    
    //MARK: Custom String Convertible
    
    override var description: String {
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}

