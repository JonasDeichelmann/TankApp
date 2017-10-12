//
//  ViewController.swift
//  TankApp
//
//  Created by Jonas Deichelmann on 22.07.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//


import UIKit
import TB
import MapKit
import CoreLocation

class ViewController: UITableViewController, CLLocationManagerDelegate {

    // - MARK: Defining Var
    @IBOutlet weak var tankstellenName: UILabel!
    @IBOutlet weak var tankstellenOrt: UILabel!

    @IBOutlet weak var preisDiesel: UILabel!
    @IBOutlet weak var preisSuperE10: UILabel!
    @IBOutlet weak var preisSuper: UILabel!
    @IBOutlet weak var verbrauchDurschittLiter: UITextField!
    @IBOutlet weak var verbrauchDurschnittMilliliter: UITextField!
    var verbrauchDurschnitt = 0.0
    @IBOutlet weak var verbrauchKilometer: UITextField!
    @IBOutlet weak var verbrauchKosten: UILabel!
    @IBOutlet weak var verbrauchSprit: UILabel!
    @IBOutlet weak var eingabePreis: UITextField!
    var  spritPreis = 0.0
//    var nextStation = GasStation()

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    // - MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        navigationController?.navigationBar.topItem?.title = "Caluclator!"

        // TODO:
        updateGasstation()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    @IBAction func berechneVerbrauch(_ sender: Any) {
        if spritPreis == 0.0 {
            let alert = UIAlertController(title: "Spritauswahl fehlt", message: "Bitte wähle eine Spritart aus um den Preis zu errechnen", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            verbrauchDurschnitt = Double("\(String(describing: verbrauchDurschittLiter.text!))"+"."+"\(String(describing: verbrauchDurschnittMilliliter.text!))")!
            verbrauchSprit.text = String(Double(verbrauchKilometer.text!)! / 100 * Double(verbrauchDurschnitt))
            verbrauchKosten.text = String(Double(verbrauchSprit.text!)!*spritPreis)
        }
    }

    // - MARK: Table View Function

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0{
            return nil
        }
        if indexPath.section == 1{
            if let cell = tableView.cellForRow(at: indexPath) {
                spritPreis = Double(cell.detailTextLabel?.text! ?? "0.0")!
            }
            if indexPath.row == 3{
                if eingabePreis.text == "" {
                    spritPreis = 0.0
                }else{
                    spritPreis = Double(eingabePreis.text!)!
                }
            }
            return indexPath
        }
        if indexPath.section == 2{
            return nil
        }
        return nil
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            TB.info("If status has not yet been determied, ask for authorization")
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            TB.info("If authorized when in use")
            locationManager.startUpdatingLocation()
            let loc = locationManager.location
            let lat = (loc?.coordinate.latitude)!
            let long = (loc?.coordinate.longitude)!
            UserCoordinates.shared.coordinateLat = lat
            UserCoordinates.shared.coordinateLong = long
            updateGasstation()
            break
        case .authorizedAlways:
            TB.info("If always authorized")

            updateGasstation()
            break
        case .restricted:
            TB.info("If restricted by e.g. parental controls. User can't enable Location Services")
            break
        case .denied:
            TB.info("If user denied your app access to Location Services, but can grant access from Settings.app")
            break
        }
    }

    @objc func updateGasstation(){
        locationManager.startUpdatingLocation()
        let loc = locationManager.location
        let lat = (loc?.coordinate.latitude)!
        let long = (loc?.coordinate.longitude)!

        UserCoordinates.shared.coordinateLat = lat
        UserCoordinates.shared.coordinateLong = long
        nextStation = apiCall()
        TB.info("Data from the Gasstation: \(nextStation)")
        tankstellenName.text =  nextStation.brand + ": " + nextStation.name
        tankstellenOrt.text = nextStation.location.place + "," + nextStation.location.street
        preisSuper.text = String(nextStation.gas.e5)
        preisDiesel.text = String(nextStation.gas.diesel)
        preisSuperE10.text = String(nextStation.gas.e10)
    }
}

