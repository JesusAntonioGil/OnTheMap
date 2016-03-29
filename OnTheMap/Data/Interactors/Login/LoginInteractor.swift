//
//  LoginInteractor.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


@objc protocol LoginInteractorDelegate {
    func loginInteractorSuccess(loginSession: LoginSession)
    func loginInteractorError(error: NSError)
}


class LoginInteractor: NSObject, LoginInteractorProtocol {

    //Injected
    var requestClient: RequestClient!
    
    var delegate: LoginInteractorDelegate?
    var mapperHelper = MapperHelper()
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        requestClient.delegate = self
        mapperHelper.delegate = self
    }
    
    //MARK: PUBLIC
    
    func login(loginDTO: LoginDTO) {
        let endpoint: URLEndpoint = .Login(loginDTO: loginDTO)
        requestClient.request(endpoint)
    }
}


extension LoginInteractor: RequestClientDelegate {
    
    func requestClientSuccess(data: AnyObject) {
        mapperHelper.mapperResponse(data, transform: {Mapper<LoginSession>().map($0)})
    }
    
    func requestClientError(error: NSError) {
        delegate?.loginInteractorError(error)
    }
}

extension LoginInteractor: MapperHelperDelegate {
    
    func mapperHelperDelegateSuccess(data: Mappable) {
        delegate?.loginInteractorSuccess(data as! LoginSession)
    }
    
    func mapperHelperDelegateError(error: NSError) {
        delegate?.loginInteractorError(error)
    }
}
