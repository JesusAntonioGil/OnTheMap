//
//  LinkViewController.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 30/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import PKHUD
import CoreLocation
import MapKit


class LinkViewController: UIViewController {

    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    //Injected
    var presenter: LinkPresenter!
    
    var placemark: CLPlacemark!
    var mapString: String!
    var studentLocation: StudentLocationStruct!
    
    
    //MARK: LIFE CYCLE
    
    override func typhoonDidInject() {
        presenter.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Link"
        
        mapView.addAnnotation(MKPlacemark(placemark: placemark))
        let region = MKCoordinateRegionMake((placemark.location?.coordinate)!, MKCoordinateSpanMake(0.25, 0.25));
        let adjustedRegion = mapView.regionThatFits(region)
        mapView.setRegion(adjustedRegion, animated: true)
    }
    

    //MARK: ACTIONS
    
    @IBAction func onSubmitButtonTap(sender: AnyObject) {
        presenter.updateLocation(placemark, mapString: mapString, mediaURL: linkTextField.text!, studentLocation: studentLocation)
    }
    
}

extension LinkViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LinkViewController: LinkPresenterDelegate {
    
    func linkPresenterSuccess() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func linkPresenterError(error: NSError) {
        
    }
}
