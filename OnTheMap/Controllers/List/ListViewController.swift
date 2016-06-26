//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Jesús Antonio Gil on 29/03/16.
//  Copyright © 2016 Jesús Antonio Gil. All rights reserved.
//

import UIKit
import PKHUD


class ListViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    //Injected
    var presenter: MapPresenter!
    
    //var studentLocations: [StudentLocationStruct]!
    
    
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
    
}


extension ListViewController: MapPresenterDelegate {
    
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
    
    func mapPresenterStudentLocationsSuccess() {
        dispatch_async(dispatch_get_main_queue(),{
            HUD.hide()
            //self.studentLocations = studentLocations
            self.tableView.reloadData()
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

extension ListViewController: UITableViewDelegate {
 
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(SharedLocations.sharedInstance.studentLocations != nil) {
            return SharedLocations.sharedInstance.studentLocations.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = SharedLocations.sharedInstance.studentLocations[indexPath.row].firstName + " " + SharedLocations.sharedInstance.studentLocations[indexPath.row].lastName
        cell.detailTextLabel?.text = SharedLocations.sharedInstance.studentLocations[indexPath.row].mediaURL
        cell.imageView?.image = UIImage(named: "poi")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let requestUrl = NSURL(string: SharedLocations.sharedInstance.studentLocations[indexPath.row].mediaURL) {
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