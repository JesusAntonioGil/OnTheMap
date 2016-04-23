//
//  UpdateLocationDTO.swift
//  OnTheMap
//
//  Created by Jesus Antonio Gil on 23/4/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


class UpdateLocationDTO: NSObject {

    var objectId: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: String
    var longitude: String
    
    
    
    init(objectId: String, uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: String, longitude: String) {
        self.objectId = objectId
        self.uniqueKey = uniqueKey
        self.firstName = firstName
        self.lastName = lastName
        self.mapString = mapString
        self.mediaURL = mediaURL
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var parameters: String {
        return objectId
    }
    
    var body: String {
        return "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mapString)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}"
    }
}
