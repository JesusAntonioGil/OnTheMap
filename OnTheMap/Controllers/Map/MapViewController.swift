//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import PKHUD


class MapViewController: UIViewController {

    //Injected
    var presenter: MapPresenterProtocol!
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        presenter.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.show(.Progress)
        presenter.studentLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: ACTIONS
    
    @IBAction func onLogoutButtonTap(sender: AnyObject) {
        HUD.show(.Progress)
        presenter.logout()
    }
    
    @IBAction func onRefreshButtonTap(sender: AnyObject) {
        
    }
    
    
    
}


extension MapViewController: MapPresenterDelegate {
    
    func mapPresenterLogoutSuccess() {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.hide()
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func mapPresenterLogoutError(error: NSError) {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.show(.Label(error.localizedDescription))
            HUD.hide(afterDelay: 2.0)
        })
    }
    
    func mapPresenterStudentLocationsSuccess(studentLocationsResponse: StudentLocationsResponse) {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.hide()
        })
    }
    
    func mapPresenterStudentLocationsError(error: NSError) {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.show(.Label(error.localizedDescription))
            HUD.hide(afterDelay: 2.0)
        })
    }
}