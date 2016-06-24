//
//  LocationViewController.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 30/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import PKHUD
import CoreLocation


class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!

    //Injected
    var controllerAssembly: ControllerAssembly!
    
    var studentLocation: StudentLocation = StudentLocation()
    
    
    //MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentLocation.uniqueKey = "6507580000"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: ACTIONS
    
    @IBAction func onCancelButtonTap(sender: AnyObject) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onMapButtonTap(sender: AnyObject) {
        if(locationTextField.text?.isEmpty == true) {
            HUD.show(.Label("Must enter a Location"))
            HUD.hide(afterDelay: 2.0)
        } else {
            checkAddressString()
        }
    }
    
    //MARK: PRIVATE
    
    private func checkAddressString() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationTextField.text!) { (placemarks, error) in
            if(error != nil) {
                HUD.show(.Label("Could not geocode the address"))
                HUD.hide(afterDelay: 2.0)
            } else {
               self.pushToLinkViewController(placemarks![0])
            }
        }
    }
    
    private func pushToLinkViewController(placemark: CLPlacemark) {
        let linkViewController: LinkViewController = controllerAssembly.linkViewController() as! LinkViewController
        linkViewController.placemark = placemark
        linkViewController.mapString = locationTextField.text
        linkViewController.studentLocation = studentLocation
        navigationController?.pushViewController(linkViewController, animated: true)
    }

}
