//
//  LinkPresenter.swift
//  OnTheMap
//
//  Created by Jesus Antonio Gil on 24/4/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import CoreLocation


@objc protocol LinkPresenterDelegate {
    func linkPresenterSuccess()
    func linkPresenterError(error: NSError)
}


class LinkPresenter: NSObject, LinkPresenterProtocol {

    //Injected
    var updateStudentLocationInteractorProtocol: UpdateStudentLocationInteractorProtocol!
    
    var delegate: LinkPresenterDelegate?
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        updateStudentLocationInteractorProtocol.delegate = self
    }
    
    //MARK: PUBLIC
    
    func updateLocation(placemark: CLPlacemark, mapString: String, mediaURL: String, studentLocation: StudentLocation) {
        let updateLocationDTO = UpdateLocationDTO(objectId: studentLocation.objectId, uniqueKey: studentLocation.uniqueKey, firstName: studentLocation.firstName, lastName: studentLocation.lastName, mapString: mapString, mediaURL: mediaURL, latitude: String(placemark.location?.coordinate.latitude), longitude: String(placemark.location?.coordinate.longitude))
        
        updateStudentLocationInteractorProtocol.updateLocation(updateLocationDTO)
    }
}

extension LinkPresenter: UpdateStudentLocationInteractorDelegate {
    
    func updateStudentLocationInteractorSuccess() {
        delegate?.linkPresenterSuccess()
    }
    
    func updateStudentLocationInteractorError(error: NSError) {
        delegate?.linkPresenterError(error)
    }
}
