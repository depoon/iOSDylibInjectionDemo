//
//  LocationSwizzler.swift
//  PokemonGoHacking
//
//  Created by Kenneth Poon on 1/9/16.
//
//

import Foundation
import CoreLocation

public class LocationSwizzler: NSObject {

    static var locationManager: CLLocationManager?
    static var currentLocation = CLLocationCoordinate2DMake(1.293760, 103.853709) //Raffles City
    
    static var originalMethod: Method?
    static var swizzleMethod: Method?
    
    static var originalDelegate: CLLocationManagerDelegate?
        
    static public func turnOnSwizzleForCoordinate(){
        print("turnOnSwizzle")
        
        let m1 = class_getInstanceMethod(CLLocation.self, #selector(getter: CLLocation.coordinate))
        let m2 = class_getInstanceMethod(self, #selector(self.fakeCoordinate))        
        method_exchangeImplementations(m1, m2)   
        

    }
    
    static public func turnOnSwizzleForDelegate(){
        print("turnOnSwizzleForDelegate")
        
        let m1 = class_getInstanceMethod(CLLocationManager.self, #selector(setter: CLLocationManager.delegate))
        let m2 = class_getInstanceMethod(CLLocationManager.self, #selector(CLLocationManager.setDelegateForManager))        
        method_exchangeImplementations(m1, m2)   
        
        
    }
    
    public func fakeCoordinate() -> CLLocationCoordinate2D {
        return LocationSwizzler.currentLocation
    }
    
    static func retriggerTrackUserLocation(){
        print("retriggerTrackUserLocation")
        LocationSwizzler.locationManager?.requestLocation()
    }


}



extension CLLocationManager {
    public func setDelegateForManager(manager: CLLocationManager){
        print("CLLocation Manager Delegate Captured")
        LocationSwizzler.locationManager = self
        self.setDelegateForManager(manager: manager)
    }
    
}
