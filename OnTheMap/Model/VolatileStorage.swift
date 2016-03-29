//
//  VolatileStorage.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


class VolatileStorage: NSObject {

    static let shared = VolatileStorage()
    var loginSession: LoginSession!
}
