//
//  MapPresenterProtocol.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


@objc protocol MapPresenterProtocol {
    var delegate: MapPresenterDelegate? {get set}
    
    func logout()
}
