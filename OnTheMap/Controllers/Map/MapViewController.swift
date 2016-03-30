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
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    
    //Injected
    var presenter: MapPresenter!
    
    var locations: [StudentLocationStruct]!
    
    //MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.show(.Progress)
        presenter.delegate = self
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
        self.refreshButton.enabled = false
        HUD.show(.Progress)
        presenter.studentLocations()
    }
    
    //MARK: PRIVATE
    
    private func addStudentAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        
        for studentLocation in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(studentLocation.latitude), longitude: Double(studentLocation.longitude))
            annotation.title = studentLocation.firstName + " " + studentLocation.lastName
            annotation.subtitle = studentLocation.mediaURL
            mapView.addAnnotation(annotation)
        }
    }
    
}


extension MapViewController: MapPresenterDelegate {
    
    func mapPresenterLogoutSuccess() {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.hide()
            self.tabBarController?.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func mapPresenterLogoutError(error: NSError) {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.show(.Label(error.localizedDescription))
            HUD.hide(afterDelay: 2.0)
        })
    }
    
    func mapPresenterStudentLocationsSuccess(studentLocations: [StudentLocationStruct]) {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.hide()
            self.locations = studentLocations
            self.addStudentAnnotations()
            self.refreshButton.enabled = true
        })
    }
    
    func mapPresenterStudentLocationsError(error: NSError) {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.show(.Label(error.localizedDescription))
            HUD.hide(afterDelay: 2.0)
        })
    }
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pinView!.canShowCallout = true
        pinView!.rightCalloutAccessoryView = UIButton(type: .InfoLight)
        return pinView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let requestUrl = NSURL(string: ((view.annotation?.subtitle)!)!) {
            if UIApplication.sharedApplication().canOpenURL(requestUrl) {
                UIApplication.sharedApplication().openURL(requestUrl)
            }
            else {
                HUD.show(.Label("Invalid link"))
                HUD.hide(afterDelay: 2.0)
            }
        }
    }
    
}



