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
    
    func mapPresenterStudentLocationsSuccess(studentLocationsResponse: StudentLocationsResponse)
    func mapPresenterStudentLocationsError(error: NSError)
}


class MapPresenter: NSObject, MapPresenterProtocol {

    //Injected
    var logoutInteractorProtocol: LogoutInteractorProtocol!
    var studentLocationsInteractorProtocol: StudentLocationsInteractorProtocol!
    
    var delegate: MapPresenterDelegate?
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        logoutInteractorProtocol.delegate = self
        studentLocationsInteractorProtocol.delegate = self
    }
    
    //MARK: PUBLIC
    
    func logout() {
        logoutInteractorProtocol.logout()
    }
    
    func studentLocations() {
        studentLocationsInteractorProtocol.studentLocations()
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

extension MapPresenter: StudentLocationsInteractorDelegate {
    
    func studentLocationsInteractorSuccess(studentLocationsResponse: StudentLocationsResponse) {
        delegate?.mapPresenterStudentLocationsSuccess(studentLocationsResponse)
    }
    
    func studentLocationsInteractorError(error: NSError) {
        delegate?.mapPresenterStudentLocationsError(error)
    }
}