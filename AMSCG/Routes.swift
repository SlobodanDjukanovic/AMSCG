//
//  Routes.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 23.2.22..
//

import Foundation
import SwiftUI

struct Routes {
    @Binding var language: String
    let domain = "https://app.amscg.org/api/mobile"
    
    var appLang: String {
        language == "sr-Latn-ME" ? "me" : "en"
    }
    var currRoadCond: String {
        "\(domain)/info/road_conditions/language/\(appLang)"
    }
    var heavyVehicles: String {
        "\(domain)/info/truck_speed/language/\(appLang)"
    }
    var advices: String {
        "\(domain)/info/advices/language/\(appLang)"
    }
    var roadWorks: String {
        "\(domain)/road_conditions/\(appLang)"
    }
    var stationsChargers: String {
        "\(domain)/poi_all/fuel_station/language/\(appLang)"
    }
    var poiAll: String {
        "\(domain)/poi_all/all_categories/language/\(appLang)"
    }
    var poiServices: String {
        "\(domain)/poi_all/service/language/\(appLang)"
    }
    var poiParkings: String {
        "\(domain)/poi_all/parking/language/\(appLang)"
    }
    var poiGarages: String {
        "\(domain)/poi_all/garage/language/\(appLang)"
    }
    var poiBanks: String {
        "\(domain)/poi_all/bank/language/\(appLang)"
    }
    var poiPolice: String {
        "\(domain)/poi_all/police/language/\(appLang)"
    }
    var poiAmbulances: String {
        "\(domain)/poi_all/ambulance/language/\(appLang)"
    }
    var fuelPrices: String {
        "\(domain)/fuel/\(appLang)"
    }
    var tolls: String {
        "\(domain)/info/tolls/language/\(appLang)"
    }
    var internationalDocuments: String {
        "\(domain)/info/documents/language/\(appLang)"
    }
    var borders: String {
        "\(domain)/info/borders/language/\(appLang)"
    }
    let meteo = "http://www.meteo.co.me"
}
