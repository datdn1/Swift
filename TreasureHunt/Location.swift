//
//  Location.swift
//  TreasureHunt
//
//  Created by datdn1 on 12/7/15.
//  Copyright © 2015 datdn1. All rights reserved.
//

import UIKit

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
}
