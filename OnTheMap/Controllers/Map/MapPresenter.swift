//
//  MapPresenter.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


protocol MapPresenterDelegate {
    func mapPresenterLogoutSuccess()
    func mapPresenterLogoutError(error: NSError)
    
    func mapPresenterStudentLocationsSuccess(studentLocations: [StudentLocationStruct])
    func mapPresenterStudentLocationsError(error: NSError)
}


class MapPresenter: NSObject {

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
        
        var locationsArray = [StudentLocationStruct]()
        for studentLocation in studentLocationsResponse.locations {
            let structLocation = StudentLocationStruct(dictionary: studentLocation.dictionaryDescription)
            locationsArray.append(structLocation)
        }
        
        delegate?.mapPresenterStudentLocationsSuccess(locationsArray)
    }
    
    func studentLocationsInteractorError(error: NSError) {
        delegate?.mapPresenterStudentLocationsError(error)
    }
}