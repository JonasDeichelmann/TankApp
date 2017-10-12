//
//  UserCoordinates.swift
//  TankApp
//
//  Created by Jonas Deichelmann on 07.10.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation
import CoreLocation

class UserCoordinates: NSObject, CLLocationManagerDelegate {
    
    
    // MARK: - Shared Instance
    
    static let shared: UserCoordinates = {
        let instance = UserCoordinates()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }

    
    // MARK: - Properties
  

    var lat = 0.0
    var long = 0.0

    var coordinateLat : Double
    {
        get {
            return lat
        }
        set(setCoordinateLat) {
            lat = setCoordinateLat
        }
    }
    var coordinateLong : Double
    {
        get {
            return long
        }
        set(setCoordinateLong) {
            long = setCoordinateLong
        }
    }
    
}
