//
//  InteractorAssembly.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import Typhoon


class InteractorAssembly: TyphoonAssembly {
    
    //MARK: RequestClient
    internal dynamic func requestClient() -> AnyObject {
        return TyphoonDefinition.withClass(RequestClient.self)
    }
    
    //MARK: LoginInteractor
    internal dynamic func loginInteractor() -> AnyObject {
        return TyphoonDefinition.withClass(LoginInteractor.self) {
            (definition) in
                definition.injectProperty("requestClient", with: self.requestClient())
        }
    }

    //MARK: LogoutInteractor
    internal dynamic func logoutInteractor() -> AnyObject {
        return TyphoonDefinition.withClass(LogoutInteractor.self) {
            (definition) in
                definition.injectProperty("requestClient", with: self.requestClient())
        }
    }
    
    //MARK: StudentLocationsInteractor
    internal dynamic func studentLocationsInteractor() -> AnyObject {
        return TyphoonDefinition.withClass(StudentLocationsInteractor.self) {
            (definition) in
                definition.injectProperty("requestClient", with: self.requestClient())
        }
    }
}
