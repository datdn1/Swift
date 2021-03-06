//
//  Location.swift
//  TreasureHunt
//
//  Created by datdn1 on 12/7/15.
//  Copyright © 2015 datdn1. All rights reserved.
//

import UIKit
import MapKit

protocol Equatable {
    func ==(lhs: Self, rhs:Self) -> Bool
}

/*
    Pass by value
*/
struct Location {
    
    // Why properties should var variable rather let variable 
    let long: Double
    let lat: Double
    
    // only copy when change value happen
    // var structA  = Struct()
    // structB  = structA        -- don't copy value
    // structB.foo = 1.0         -- copy
    
    // using let and var of struct and class different
    // var  classA  = Class()
    // let  classB = Class()
    // classA.foo  = 1.0      -- can change
    // classB.foo  = 2.0      -- can change although it's let reference
    // classB = classA        -- can't change because it's let reference
    
    // var structA = Struct()
    // let structB  = Struct()
    // structA.foo  = 1.0       -- can change 
    // structB.foo  = 2.0       -- can't change because it's let reference although foo property is var variable
    
    func distanceBetween(other: Location) -> Double {
        let locationA = CLLocation(latitude: self.lat, longitude: self.long)
        let locationB = CLLocation(latitude: other.lat, longitude: other.long)
        return locationA.distanceFromLocation(locationB)
    }
}

extension Location {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
    }
    
    var mapPoint: MKMapPoint {
        return MKMapPointForCoordinate(self.coordinate)
    }
}

extension Location : Equatable {
}

func ==(lhs: Location, rhs:Location) -> Bool {
    return (lhs.lat == rhs.lat) && (lhs.long == rhs.long)
}

