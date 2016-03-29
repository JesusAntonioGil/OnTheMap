//
//  StudentLocationsInteractor.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


@objc protocol StudentLocationsInteractorDelegate {
    func studentLocationsInteractorSuccess(studentLocationsResponse: StudentLocationsResponse)
    func studentLocationsInteractorError(error: NSError)
}


class StudentLocationsInteractor: NSObject, StudentLocationsInteractorProtocol {

    //Injected
    var requestClient: RequestClient!
    
    var delegate: StudentLocationsInteractorDelegate?
    var mapperHelper = MapperHelper()
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        requestClient.delegate = self
        mapperHelper.delegate = self
    }
    
    //MARK: PUBLIC
    
    func studentLocations() {
        let endpoint: URLEndpoint = .StudentLocations()
        requestClient.request(endpoint)
    }

}


extension StudentLocationsInteractor: RequestClientDelegate {
    
    func requestClientSuccess(data: AnyObject) {
        mapperHelper.mapperResponse(data, transform: {Mapper<StudentLocationsResponse>().map($0)})
    }
    
    func requestClientError(error: NSError) {
        delegate?.studentLocationsInteractorError(error)
    }
}

extension StudentLocationsInteractor: MapperHelperDelegate {
    
    func mapperHelperDelegateSuccess(data: Mappable) {
        delegate?.studentLocationsInteractorSuccess(data as! StudentLocationsResponse)
    }
    
    func mapperHelperDelegateError(error: NSError) {
        delegate?.studentLocationsInteractorError(error)
    }
}
