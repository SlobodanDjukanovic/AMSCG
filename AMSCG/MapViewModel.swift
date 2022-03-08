//
//  MapViewModel.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 17.1.22..
//

import MapKit
import SwiftUI

extension CLLocationCoordinate2D {
    // Returns the distance between two coordinates in meters
    func distance(to: CLLocationCoordinate2D) -> CLLocationDistance {
        MKMapPoint(self).distance(to: MKMapPoint(to))
    }
    
    func distanceString(to: CLLocationCoordinate2D) -> String {
        let dist = MKMapPoint(self).distance(to: MKMapPoint(to))
        if dist < 1000 {
            return String(format: "%d m", Int(dist))
        } else {
            return String(format: "%.2f km", dist / 1000)
        }
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let startingLocation = Location.example.coordinate
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
    
    @Published var region = MKCoordinateRegion(center: MapViewModel.startingLocation, span: MapViewModel.defaultSpan)
    @Published var myLocation = startingLocation
    @Published var isLocationAvailable = false
    @Published var showLocationInfo = true
    @Published var locationInfoMessage = LocalizedStringKey("location_info")
    @Published var currentLocation = Location.example
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters //kCLLocationAccuracyBestForNavigation
            locationManager!.startUpdatingLocation()
            locationManager!.delegate = self
        } else {
            isLocationAvailable = false
            locationInfoMessage = LocalizedStringKey("location_disabled")
        }
    }
    
    private func checkLocalizationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                isLocationAvailable = false
                showLocationInfo = true
                locationInfoMessage = LocalizedStringKey("location_restricted")
            case .denied:
                isLocationAvailable = false
                showLocationInfo = true
                locationInfoMessage = LocalizedStringKey("location_denied")
            case .authorizedAlways, .authorizedWhenInUse:
                isLocationAvailable = true
                showLocationInfo = false
                goToMyLocation()
            @unknown default:
                isLocationAvailable = false
                locationInfoMessage = LocalizedStringKey("location_unknown")
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocalizationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentCLL: CLLocation = locations.last ?? CLLocation(latitude: MapViewModel.startingLocation.latitude, longitude: MapViewModel.startingLocation.longitude)
        currentLocation = Location(id: -1,
                                   type: "service",
                                   title: "",
                                   description: "Current location",
                                   latitude: "\(currentCLL.coordinate.latitude)",
                                   longitude: "\(currentCLL.coordinate.longitude)",
                                   web: "",
                                   phone: "",
                                   address: "")
    }
    
    func goToMyLocation() {
        guard let locationManager = locationManager else { return }
        self.myLocation = locationManager.location?.coordinate ?? MapViewModel.startingLocation
        self.region = MKCoordinateRegion(center: self.myLocation, span: MapViewModel.defaultSpan)
    }
}
