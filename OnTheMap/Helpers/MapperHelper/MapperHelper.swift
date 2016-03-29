//
//  MapperHelper.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import ObjectMapper


protocol MapperHelperDelegate {
    func mapperHelperDelegateSuccess(data: Mappable)
    func mapperHelperDelegateError(error: NSError)
}

class MapperHelper: NSObject {

    var delegate: MapperHelperDelegate?
    
    
    //MARK: PUBLIC
    
    func mapperResponse<T: Mappable>(data: AnyObject, transform: (AnyObject) -> T?) {
        if let result = Mapper<T>().map(data) {
            delegate?.mapperHelperDelegateSuccess(result)
        } else {
            delegate?.mapperHelperDelegateError(NSError(domain: "OnTheMap", code: 900, userInfo: [NSLocalizedDescriptionKey: "Request succeded but JSON mapping failed"]))
        }
    }

}
