//
//  HelperAssembly.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import Typhoon


class HelperAssembly: TyphoonAssembly {

    //MARK: MapperHelper
    
    internal dynamic func mapperHelper() -> AnyObject {
        return TyphoonDefinition.withClass(MapperHelper.self)
    }
}
