//
//  RouteViewController.swift
//  TankApp
//
//  Created by Jonas Deichelmann on 07.10.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation
import UIKit
import TB
import MapKit
import CoreLocation

class RouteViewController: UIViewController, CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationController?.title = "Route"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}
