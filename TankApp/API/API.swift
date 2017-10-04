//
//  API.swift
//  TankApp
//
//  Created by Jonas Deichelmann on 24.07.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation
import TB

// Check to configure: https://creativecommons.tankerkoenig.de
//https://creativecommons.tankerkoenig.de/json/list.php?lat=52.521&lng=13.438&rad=1.5&sort=dist&type=all&apikey=


let config = URLSessionConfiguration.default // Session Configuration
let session = URLSession(configuration: config) // Load configuration into Session


let base = "https://creativecommons.tankerkoenig.de"
let path = "/json/list.php?"
var lat = "52.521"
var lng = "13.438"
var rad = "1.5"
var sort = "dist"
var type = "all"
let values = "lat=" + lat+"&lng="+lng + "&rad=" + rad + "&sort=" + sort + "&type="  + type
let key = APIKeys.shared.key
let url = URL(string: base + path + values + "&apikey=" + key)!

struct Swifter: Decodable {
    let brand: String
    let diesel: String
    let dist: String
    let e10: String
    let e5: String
    let houseNumber: Int
    let id: String
    let isOpen: Int
    let lat: String
    let lng: String
    let name: String
    let place: String
    let postCode: Int
    let street: String
}


let task = session.dataTask(with: url, completionHandler: {
    (data, response, error) in
    if error != nil {
        TB.error(error!.localizedDescription)
    } else {
            var names = [String]()
            do {
                if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let blogs = json["stations"] as? [[String: Any]] {
                    for blog in blogs {
                        if let name = blog["name"] as? String {
                            names.append(name)
                        }
                        if let name = blog["name"] as? String {
                            names.append(name)
                        }
                    }
                }
            } catch {
                TB.error("Error deserializing JSON: \(error)")
            }
        }

})
func apiCall(){
    task.resume()
}
func convertToDictionary(from text: String) throws -> [String: String] {
    guard let data = text.data(using: .utf8) else { return [:] }
    let anyResult: Any = try JSONSerialization.jsonObject(with: data, options: [])
    return anyResult as? [String: String] ?? [:]
}
