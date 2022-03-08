//
//  AMSCGApp.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 13.1.22..
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Hashable {
    let id: Int
    let type: String
    let latitude: Double
    let longitude: Double
    let description: String
    let title: String
    let web: String
    let phone: String
    let address: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }

    static let example = Location(id: 0,
                                  type: "service",
                                  latitude: 42.409723,
                                  longitude: 19.247722,
                                  description: "Auto centar Šišević",
                                  title: "Naslov",
                                  web: "www.shisho.com",
                                  phone: "+36267222111",
                                  address: "Ugao višnjine i trešnjine")
}
