//
//  Models.swift
//  TankApp
//
//  Created by Jonas Deichelmann on 03.10.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation


struct GasStation {
    var name = ""
    var brand = ""
    var gas = Gas()
    var location = Location()
    var coordinates = Coordinates()
}
struct Gas {
    var diesel = 0.0
    var e10 = 0.0
    var e5 = 0.0
}
struct Location {
    var place = ""
    var postode = ""
    var street = ""
}

