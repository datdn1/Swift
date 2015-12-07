//
//  Treasure.swift
//  TreasureHunt
//
//  Created by datdn1 on 12/7/15.
//  Copyright © 2015 datdn1. All rights reserved.
//

import UIKit
import MapKit

/*
    Pass by reference
*/
class Treasure: NSObject{
    
    let what:String
    let location:Location
    
    // using convenience initialize
    // not initialize all properties 
    // and must call designated initializer
    convenience init(what: String, long: Double, lat: Double) {
//        self.what = what
//        self.location = Location(long: long, lat:lat)
        self.init(what:what, location: Location(long: long, lat:lat))
    }
    
    init(what: String, location: Location) {
        self.what = what
        self.location = location
    }
}

class HistoryTreasure : Treasure {
    let year: Int
    init(what: String, year: Int, lat: Double, long: Double) {
        self.year = year    // should direct initialize properties of subclass
        let location = Location(long: long, lat: lat)
        super.init(what: what, location: location)          // must call designted initializer of base class
    }
}

class FactTreasure: Treasure {
    let fact: String
    init(what: String, fact: String, lat: Double, long: Double) {
        self.fact = fact
        let location = Location(long: long, lat: lat)
        super.init(what: what, location: location)
    }
}

class HQTreasure : Treasure {
    let company: String
    init(company: String, lat: Double, long: Double) {
        self.company = company
        let location = Location(long: long, lat: lat)
        super.init(what: company + " headquarters", location: location)
    }
}

// extension logic code 
// add new properties(only Swift) and methods(Object-C + Swift)
extension Treasure: MKAnnotation {
    
    // computed properties
    // only using var keyword
    var coordinate: CLLocationCoordinate2D {
        return self.location.coordinate
    }
    
    var title: String? {
        return self.what
    }
}
















