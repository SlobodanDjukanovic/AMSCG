//
//  DataModels.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 18.2.22..
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Hashable {
    let id: Int
    let type: String
    let title: String
    let description: String
    let latitude: String
    let longitude: String
    let web: String
    let phone: String
    let address: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: Double(self.latitude) ?? 42.442183,
                               longitude: Double(self.longitude) ?? 19.245558)
    }

    static let example = Location(id: 0,
                                  type: "service",
                                  title: "AMSCG",
                                  description: "Auto-moto savez Crne Gore",
                                  latitude: "42.442183",
                                  longitude: "19.245558",
                                  web: "https://amscg.org",
                                  phone: "19807",
                                  address: "Rimski trg 60, Podgorica")
}

struct Locations: Codable {
    var data: [Location]
}


struct RoadCondition: Identifiable, Codable, Hashable {
    let id: Int
    let type: String
    let title: String
    let description: String
    let latitude: String
    let longitude: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: Double(self.latitude) ?? 42.442183,
                               longitude: Double(self.longitude) ?? 19.245558)
    }

    static let example = RoadCondition(id: 0,
                                       type: "roadwork",
                                       title: "AMSCG",
                                       description: "Auto-moto savez Crne Gore",
                                       latitude: "42.442183",
                                       longitude: "19.245558")
    
}

struct RoadConditions: Codable {
    var data: [RoadCondition]
}

struct Info: Codable, Hashable {
    let id: Int
    let language: String
    let type: String
    let text: String
    let date_created: String
    let date_modified: String
}

struct JSONInfo: Decodable {
    let action: Bool
    let info: Info
}

struct FuelPrice: Codable, Hashable {
    let name: String
    let price: String
}

struct JSONFuelPrice: Decodable {
    let action: Bool
    let data: [FuelPrice]
    let msg: String
}
