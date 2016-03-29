//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 28/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //Injected
    var presenter: LoginPresenterProtocol!
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        presenter.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: ACTIONS
    
    @IBAction func onLoginButtonTap(sender: AnyObject) {
        presenter.login(emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func onSignUpButtonTap(sender: AnyObject) {
        
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
    
}


