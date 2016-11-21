//
//  CLLocationSwizzler.swift
//  PokemonGoHacking
//
//  Created by Kenneth Poon on 5/9/16.
//
//

import Foundation
import CoreLocation

open class CLLocationSwizzler: NSObject{
    
    static open func turnOnSwizzle(){
        let m1 = class_getInstanceMethod(CLLocation.self, #selector(getter: CLLocation.coordinate))
        let m2 = class_getInstanceMethod(CLLocation.self, #selector(CLLocation.override_coordinate))        
        method_exchangeImplementations(m1, m2)
        
        let a = CLLocation(latitude: 1.0, longitude: 1.1)
        print("a coor: \(a.coordinate)")
    }
}

extension CLLocation {
    
    func override_coordinate() ->CLLocationCoordinate2D {
        
        return CLLocationCoordinate2DMake(1.356156, 103.871630)
    }
}
