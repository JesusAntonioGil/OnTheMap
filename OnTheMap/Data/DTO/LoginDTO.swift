//
//  LoginDTO.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


class LoginDTO: NSObject {

    var username: String
    var password: String
    
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    var parameters: [String: AnyObject] {
        return ["udacity":[
            "username": username,
            "password": password]
        ]
    }
    
}
