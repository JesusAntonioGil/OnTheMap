//
//  UpdateStudentLocationInteractorProtocol.swift
//  OnTheMap
//
//  Created by Jesus Antonio Gil on 23/4/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol UpdateStudentLocationInteractorProtocol {
    var delegate: UpdateStudentLocationInteractorDelegate? {get set}
    
    func updateLocation(updateLocationDTO: UpdateLocationDTO)
}
