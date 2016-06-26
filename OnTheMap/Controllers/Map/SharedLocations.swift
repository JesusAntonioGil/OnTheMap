//
//  SharedLocations.swift
//  OnTheMap
//
//  Created by Jesus Antonio Gil on 26/6/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


class SharedLocations: NSObject {

    var studentLocations: [StudentLocationStruct]!
    
    static let sharedInstance = SharedLocations()
}
