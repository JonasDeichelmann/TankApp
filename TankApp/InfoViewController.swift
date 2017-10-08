//
//  InfoViewController.swift
//  TankApp
//
//  Created by Jonas Deichelmann on 07.10.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation
import TB

class InfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationController?.title = "Infos"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func donateButton(_ sender: Any) {
        guard let url = URL(string: "https://www.paypal.com/de/cgi-bin/webscr?cmd=_flow&SESSION=Dc_dl99M2niMkTWooP9Up1QtILpZr7uGhzacz4x3uq8BqrlfwkrKdZMDKaW&dispatch=5885d80a13c0db1f8e263663d3faee8d795bb2096d7a7643a72ab88842aa1f54&rapidsState=Donation__DonationFlow___StateDonationLogin&rapidsStateSignature=422d7e0fb22e5d69e22c4e380ffc94a96e2ebdda") else {
            return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    //
}
