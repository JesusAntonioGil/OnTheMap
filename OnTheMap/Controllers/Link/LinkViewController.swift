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
    var presenter: LinkPresenterProtocol!
    
    var placemark: CLPlacemark!
    var mapString: String!
    var studentLocation: StudentLocation!
    
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //MARK: ACTIONS
    
    @IBAction func onSubmitButtonTap(sender: AnyObject) {
        presenter.updateLocation(placemark, mapString: mapString, mediaURL: linkTextField.text!, studentLocation: studentLocation)
    }
    
}

extension LinkViewController: LinkPresenterDelegate {
    
    func linkPresenterSuccess() {
        
    }
    
    func linkPresenterError(error: NSError) {
        
    }
}
