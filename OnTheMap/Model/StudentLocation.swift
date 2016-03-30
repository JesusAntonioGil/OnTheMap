//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


final class StudentLocation: NSObject {

    var createdAt: NSDate!
    var firstName: String!
    var lastName: String!
    var latitude: Float!
    var longitude: Float!
    var mapString: String!
    var mediaURL: String!
    var objectId: String!
    var uniqueKey: String!
    var updatedAt: NSDate!
}


extension StudentLocation: Mappable {
    
    convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        createdAt <- map["createdAt"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        mapString <- map["mapString"]
        mediaURL <- map["mediaURL"]
        objectId <- map["objectId"]
        uniqueKey <- map["uniqueKey"]
        updatedAt <- map["updatedAt"]
    }
    
    //MARK: Custom String Convertible
    
    override var description: String {
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
    
    var dictionaryDescription: [String: AnyObject] {
        return Mapper().toJSON(self)
    }
}


class StudentLocationTransform: TransformType {
    
    typealias Object = StudentLocation
    typealias JSON = String
    
    init() { }
    
    func transformFromJSON(value: AnyObject?) -> StudentLocation? {
        
        guard value != nil else {
            return nil
        }
        return Mapper<StudentLocation>().map(value)
    }
    
    func transformToJSON(value: StudentLocation?) -> JSON? {
        guard value != nil else {
            return nil
        }
        return Mapper().toJSONString(value!, prettyPrint: true)!
    }
    
}


struct StudentLocationStruct {
    
    var createdAt: NSDate!
    var firstName: String!
    var lastName: String!
    var latitude: Float!
    var longitude: Float!
    var mapString: String!
    var mediaURL: String!
    var objectId: String!
    var uniqueKey: String!
    var updatedAt: NSDate!
    
    
    init(dictionary: [String: AnyObject]) {
        if(dictionary["createdAt"] != nil) { createdAt = dictionary["createdAt"] as! NSDate }
        if(dictionary["firstName"] != nil) {firstName = dictionary["firstName"] as! String }
        if(dictionary["lastName"] != nil) { lastName = dictionary["lastName"] as! String }
        if(dictionary["latitude"] != nil) { latitude = dictionary["latitude"] as! Float }
        if(dictionary["longitude"] != nil) { longitude = dictionary["longitude"] as! Float }
        if(dictionary["mapString"] != nil) { mapString = dictionary["mapString"] as! String }
        if(dictionary["mediaURL"] != nil) { mediaURL = dictionary["mediaURL"] as! String }
        if(dictionary["objectId"] != nil) { objectId = dictionary["objectId"] as! String }
        if(dictionary["uniqueKey"] != nil) { uniqueKey = dictionary["uniqueKey"] as! String }
        if(dictionary["updatedAt"] != nil) { updatedAt = dictionary["updatedAt"] as! NSDate }
    }
}