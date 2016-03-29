//
//  MapPresenter.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol MapPresenterDelegate {
    func mapPresenterLogoutSuccess()
    func mapPresenterLogoutError(error: NSError)
}


class MapPresenter: NSObject, MapPresenterProtocol {

    //Injected
    var logoutInteractorProtocol: LogoutInteractorProtocol!
    
    var delegate: MapPresenterDelegate?
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        logoutInteractorProtocol.delegate = self
    }
    
    //MARK: PUBLIC
    
    func logout() {
        logoutInteractorProtocol.logout()
    }
}


extension MapPresenter: LogoutInteractorDelegate {
    
    func logoutInteractorSuccess(logoutSession: LogoutSession) {
        delegate?.mapPresenterLogoutSuccess()
    }
    
    func logoutInteractorError(error: NSError) {
        delegate?.mapPresenterLogoutError(error)
    }
}
