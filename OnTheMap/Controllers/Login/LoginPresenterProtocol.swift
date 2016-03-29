//
//  LoginPresenterProtocol.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol LoginPresenterProtocol {
    var delegate: LoginPresenterDelegate? {get set}
    
    func login(username: String, password: String)
}
