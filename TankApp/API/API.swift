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
let myGroup = DispatchGroup()

let base = "https://creativecommons.tankerkoenig.de"
let path = "/json/list.php?"
var lat = String(UserCoordinates.shared.lat)
var lng = String(UserCoordinates.shared.long)
var rad = "10"
var sort = "dist"
var type = "all"
let values = "lat=" + lat+"&lng="+lng + "&rad=" + rad + "&sort=" + sort + "&type="  + type
let key = APIKeys.shared.key
let url = URL(string: base + path + values + "&apikey=" + key)!
var nextStation = GasStation()

let task = session.dataTask(with: url, completionHandler: {
    (data, response, error) in
    if error != nil {
        TB.error(error!.localizedDescription)
    } else {
        do {
            if let data = data,
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                let blogs = json["stations"] as? [[String: Any]] {
                var i = 0
                var station = [GasStation](repeating: GasStation(), count: (blogs.count))
                for blog in blogs {
                    if let name = blog["name"] as? String {
                        station[i].name = name
                    }
                    if let brand = blog["brand"] as? String {
                        station[i].brand  = brand
                    }
                    if let diesel = blog["diesel"] as? Double {
                        station[i].gas.diesel  = diesel
                    }
                    if let e10 = blog["e10"] as? Double {
                        station[i].gas.e10  = e10
                    }
                    if let e5 = blog["e5"] as? Double {
                        station[i].gas.e5  = e5
                    }
                    if let place = blog["place"] as? String {
                        station[i].location.place  = place
                    }
                    if let postode = blog["postode"] as? String {
                        station[i].location.postode  = postode
                    }
                    if let street = blog["street"] as? String {
                        station[i].location.street  = street
                    }
                    if let latitude = blog["latitude"] as? Double {
                        station[i].coordinates.latitude  = latitude
                    }
                    if let longitude = blog["longitude"] as? Double {
                        station[i].coordinates.longitude  = longitude
                    }
                    i = i + 1
                }
                if station.count != 0 {
                    nextStation = station[0]
                    TB.info("stations: \(station)")
                }else{
                    TB.error("No gasstation in range")
                }
                
            }
            } catch {
                TB.error("Error deserializing JSON: \(error)")
            }
        }

})
func apiCall() -> GasStation{
    task.resume()
    var temp = 1
    while task.state != .completed {
        if temp == 6{
            TB.warn("Didn't wait for the end of the API Call, because of a timeout")
            break
        }
        usleep(500000)
        temp += 1
    }
    return nextStation
}

