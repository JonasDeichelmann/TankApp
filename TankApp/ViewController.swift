//
//  ViewController.swift
//  TankApp
//
//  Created by Jonas Deichelmann on 22.07.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//


import UIKit
import TB

class ViewController: UITableViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        apiCall()
        // Do any additional setup after loading the view, typically from a nib.
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
}

