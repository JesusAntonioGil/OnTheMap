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
    
    internal dynamic func mapViewController() -> AnyObject {
        return TyphoonDefinition.withClass(MapViewController.self) {
            (definition) in
                definition.injectProperty("presenter", with: self.mapPresenter())
                definition.injectProperty("controllerAssembly", with: self)
        }
    }
    
    internal dynamic func mapPresenter() -> AnyObject {
        return TyphoonDefinition.withClass(MapPresenter.self) {
            (definition) in
                definition.injectProperty("logoutInteractorProtocol", with: self.interactorAssembly.logoutInteractor())
                definition.injectProperty("studentLocationsInteractorProtocol", with: self.interactorAssembly.studentLocationsInteractor())
        }
    }
    
    internal dynamic func listViewController() -> AnyObject {
        return TyphoonDefinition.withClass(ListViewController.self) {
            (definition) in
                definition.injectProperty("presenter", with: self.mapPresenter())
        }

    }
    
    //MARK: LocationViewController
    
    internal dynamic func editPositionNavigationController() -> AnyObject {
        return TyphoonDefinition.withFactory(storyboard("Main" as NSString, factory: self), selector: instantiateControllerSelector, parameters: { (method) -> Void in
            method.injectParameterWith("editPositionNavigationController")
            }, configuration: nil)
    }
    
    internal dynamic func locationViewController() -> AnyObject {
        return TyphoonDefinition.withClass(LocationViewController.self) {
            (definition) in
                definition.injectProperty("controllerAssembly", with: self)
        }
    }
    
    //MARK: LinkViewController
    
    internal dynamic func linkViewController() -> AnyObject {
        return TyphoonDefinition.withFactory(storyboard("Main" as NSString, factory: self), selector: instantiateControllerSelector, parameters: { (method) -> Void in
            method.injectParameterWith("LinkViewController")
            }, configuration: nil)
    }
}
