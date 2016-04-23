//
//  UpdateStudentLocationInteractor.swift
//  OnTheMap
//
//  Created by Jesus Antonio Gil on 23/4/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


@objc protocol UpdateStudentLocationInteractorDelegate {
    func updateStudentLocationInteractorSuccess()
    func updateStudentLocationInteractorError(error: NSError)
}


class UpdateStudentLocationInteractor: NSObject, UpdateStudentLocationInteractorProtocol {

    //Injected
    var requestClient: RequestClient!
    
    var delegate: UpdateStudentLocationInteractorDelegate?
    var mapperHelper = MapperHelper()
    
    
    //MARK: PUBLIC
    
    func updateLocation(updateLocationDTO: UpdateLocationDTO) {
        let endpoint: URLEndpoint = .UpdateStudentLocetion(updateLocationDTO: updateLocationDTO)
        requestClient.delegate = self
        requestClient.request(endpoint)
    }

}

extension UpdateStudentLocationInteractor: RequestClientDelegate {
    
    func requestClientSuccess(data: AnyObject) {
        mapperHelper.delegate = self
        mapperHelper.mapperResponse(data, transform: {Mapper<UpdateLocationResponse>().map($0)})
    }
    
    func requestClientError(error: NSError) {
        delegate?.updateStudentLocationInteractorError(error)
    }
}

extension UpdateStudentLocationInteractor: MapperHelperDelegate {
    
    func mapperHelperDelegateSuccess(data: Mappable) {
        delegate?.updateStudentLocationInteractorSuccess()
    }
    
    func mapperHelperDelegateError(error: NSError) {
        delegate?.updateStudentLocationInteractorError(error)
    }
}
