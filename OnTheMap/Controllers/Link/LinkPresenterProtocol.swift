//
//  LinkPresenterProtocol.swift
//  OnTheMap
//
//  Created by Jesus Antonio Gil on 24/4/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import CoreLocation


@objc protocol LinkPresenterProtocol {
    var delegate: LinkPresenterDelegate? {get set}
    
    func updateLocation(placemark: CLPlacemark, mapString: String, mediaURL: String, studentLocation: StudentLocation)
}
