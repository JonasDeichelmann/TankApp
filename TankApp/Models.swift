//
//  Models.swift
//  TankApp
//
//  Created by Jonas Deichelmann on 03.10.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation
struct GasStation {
    let name: String
    let brand: String
    let gas: (diesel: Double, e10: Double, e5: Double)
    let location: (place: String, postode: String, street: String)
    let coordinates: (latitude: Double, longitude: Double)
}
