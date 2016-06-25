//
//  LoginPresenter.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


var userKey: String = ""


@objc protocol LoginPresenterDelegate {
    func loginPresenterSuccess()
    func loginPresenterError(error: NSError)
}


class LoginPresenter: NSObject, LoginPresenterProtocol {

    //Injected
    var loginInteractorProtocol: LoginInteractorProtocol!
    
    var delegate: LoginPresenterDelegate?
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        loginInteractorProtocol.delegate = self
    }
    
    //MARK: PUBLIC
    
    func login(username: String, password: String) {
        let loginDTO = LoginDTO(username: username, password: password)
        loginInteractorProtocol.login(loginDTO)
    }
}


extension LoginPresenter: LoginInteractorDelegate {
    
    func loginInteractorSuccess(loginSession: LoginSession) {
        userKey = loginSession.account.key
        delegate?.loginPresenterSuccess()
    }
    
    func loginInteractorError(error: NSError) {
        delegate?.loginPresenterError(error)
    }
}
