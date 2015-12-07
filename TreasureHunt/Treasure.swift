//
//  Treasure.swift
//  TreasureHunt
//
//  Created by datdn1 on 12/7/15.
//  Copyright © 2015 datdn1. All rights reserved.
//

import UIKit

class Treasure: NSObject {
    
    let what:String
    let long:Double
    let lat:Double
    
    init(what: String, long: Double, lat: Double) {
        self.what = what
        self.long = long
        self.lat = lat
    }
    
    

}
