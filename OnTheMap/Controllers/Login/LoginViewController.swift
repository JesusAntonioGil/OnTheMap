//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import PKHUD


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //Injected
    var presenter: LoginPresenterProtocol!
    var controllerAssembly: ControllerAssembly!
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        presenter.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: ACTIONS
    
    @IBAction func onLoginButtonTap(sender: AnyObject) {
        HUD.show(.Progress)
        presenter.login(emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func onSignUpButtonTap(sender: AnyObject) {
        if let requestUrl = NSURL(string: "https://www.udacity.com/account/auth#!/signin") {
            UIApplication.sharedApplication().openURL(requestUrl)
        }
    }
    

}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        
        return true
    }
}

extension LoginViewController: LoginPresenterDelegate {
    
    func loginPresenterSuccess() {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.hide()
            
            let mapTabBarController: UITabBarController = self.controllerAssembly.mapTabBarController() as! UITabBarController
            mapTabBarController.modalTransitionStyle = .CrossDissolve
            self.navigationController?.presentViewController(mapTabBarController, animated: true, completion: nil)
        })
    }
    
    func loginPresenterError(error: NSError) {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.show(.Label(error.localizedDescription))
            HUD.hide(afterDelay: 2.0)
        })
    }
}


