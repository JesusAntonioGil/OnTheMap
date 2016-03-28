//
//  LoginPresenter.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol LoginPresenterDelegate {
    
}


class LoginPresenter: NSObject, LoginPresenterProtocol {

    var delegate: LoginPresenterDelegate?
}
