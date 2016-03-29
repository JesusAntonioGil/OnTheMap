//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import PKHUD
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
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
    
    //MARK: PRIVATE
    
    private func addStudentAnnotations(studentLocations: [StudentLocation]) {
        for studentLocation in studentLocations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(studentLocation.latitude), longitude: Double(studentLocation.longitude))
            annotation.title = studentLocation.firstName + studentLocation.lastName
            annotation.subtitle = studentLocation.mediaURL
            mapView.addAnnotation(annotation)
        }
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
            self.addStudentAnnotations(studentLocationsResponse.locations)
        })
    }
    
    func mapPresenterStudentLocationsError(error: NSError) {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.show(.Label(error.localizedDescription))
            HUD.hide(afterDelay: 2.0)
        })
    }
}




