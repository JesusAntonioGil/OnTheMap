//
//  ControllerAssembly.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import Typhoon


//Constants
private let instantiateControllerSelector: Selector = "instantiateViewControllerWithIdentifier:"


class ControllerAssembly: TyphoonAssembly {

    //Injected
    var interactorAssembly: InteractorAssembly!
    
    
    //MARK: Storyboards
    
    internal dynamic func storyboard(name: NSString, factory: TyphoonAssembly) -> AnyObject {
        return TyphoonDefinition.withClass(TyphoonStoryboard.self) {
            (definition) in
            definition.useInitializer("storyboardWithName:factory:bundle:") {
                (initializer) in
                initializer.injectParameterWith(name)
                initializer.injectParameterWith(factory)
                initializer.injectParameterWith(NSBundle.mainBundle())
            }
        }
    }
    
    //MARK: LoginViewController
    
    internal dynamic func loginViewController() -> AnyObject {
        return TyphoonDefinition.withClass(LoginViewController.self) {
            (definition) in
                definition.injectProperty("presenter", with: self.loginPresenter())
                definition.injectProperty("controllerAssembly", with: self)
        }
    }
    
    internal dynamic func loginPresenter() -> AnyObject {
        return TyphoonDefinition.withClass(LoginPresenter.self) {
            (definition) in
                definition.injectProperty("loginInteractorProtocol", with: self.interactorAssembly.loginInteractor())
        }
    }
    
    //MARK: TabBarController
    
    internal dynamic func mapTabBarController() -> AnyObject {
        return TyphoonDefinition.withFactory(storyboard("Main" as NSString, factory: self), selector: instantiateControllerSelector, parameters: { (method) -> Void in
            method.injectParameterWith("mapTabBarController")
            }, configuration: nil)
    }
}
