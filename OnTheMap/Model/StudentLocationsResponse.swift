//
//  StudentLocationsResponse.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


final class StudentLocationsResponse: NSObject {

    var locations: [StudentLocation]!
}


extension StudentLocationsResponse: Mappable {

    convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        locations <- (map["results"], StudentLocationTransform())
    }
    
    //MARK: Custom String Convertible
    
    override var description: String {
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}
