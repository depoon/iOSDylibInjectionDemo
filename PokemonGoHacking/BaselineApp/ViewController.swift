//
//  ViewController.swift
//  BaselineApp
//
//  Created by Kenneth Poon on 20/11/16.
//
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let aMapView = MKMapView(frame: self.view.bounds)
        aMapView.delegate = self
        self.view.addSubview(aMapView)
        aMapView.setUserTrackingMode(.follow, animated: true)
        
        self.mapView = aMapView
        
        if CLLocationManager.locationServicesEnabled(){
            
            let aLocationManager = CLLocationManager()
            aLocationManager.requestAlwaysAuthorization()
            aLocationManager.delegate = self
            aLocationManager.startUpdatingLocation()
            
            self.locationManager = aLocationManager
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        
    }
    
    public func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error){
    
    }
}

extension ViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let aLocation = locations.last {
            print("location: \(aLocation.coordinate)")
        }
        

    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        
    }
}
