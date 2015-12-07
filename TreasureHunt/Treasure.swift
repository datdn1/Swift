//
//  Treasure.swift
//  TreasureHunt
//
//  Created by datdn1 on 12/7/15.
//  Copyright © 2015 datdn1. All rights reserved.
//

import UIKit

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
