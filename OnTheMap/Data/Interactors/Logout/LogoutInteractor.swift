//
//  LogoutInteractor.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


@objc protocol LogoutInteractorDelegate {
    func logoutInteractorSuccess(logoutSession: LogoutSession)
    func logoutInteractorError(error: NSError)
}


class LogoutInteractor: NSObject, LogoutInteractorProtocol {

    //Injected
    var requestClient: RequestClient!
    
    var delegate: LogoutInteractorDelegate?
    var mapperHelper = MapperHelper()
    
    
    //MARK: PUBLIC
    
    func logout() {
        let endpoint: URLEndpoint = .Logout()
        requestClient.delegate = self
        requestClient.request(endpoint)
    }

}


extension LogoutInteractor: RequestClientDelegate {
    
    func requestClientSuccess(data: AnyObject) {
        mapperHelper.delegate = self
        mapperHelper.mapperResponse(data, transform: {Mapper<LogoutSession>().map($0)})
    }
    
    func requestClientError(error: NSError) {
        delegate?.logoutInteractorError(error)
    }
}

extension LogoutInteractor: MapperHelperDelegate {
    
    func mapperHelperDelegateSuccess(data: Mappable) {
        delegate?.logoutInteractorSuccess(data as! LogoutSession)
    }
    
    func mapperHelperDelegateError(error: NSError) {
        delegate?.logoutInteractorError(error)
    }
}
