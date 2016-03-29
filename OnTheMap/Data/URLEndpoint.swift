//
//  URLEndpoint.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


enum URLEndpoint {

    case Login(loginDTO: LoginDTO)
    case Logout()
    case StudentLocations()
}
