//
//  LocationCategoryMap.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 15.1.22..
//

import CoreLocationUI
import SwiftUI
import MapKit

struct LocationCategoryMap: View {
    @EnvironmentObject var mapModel: MapViewModel
    
    @State private var selectedPlace: Location = Location.example
    @Binding var mapCenterRegion: MKCoordinateRegion
    @Binding var categoryLocations: [Location]
    
    @State private var showingSheet = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $mapCenterRegion, showsUserLocation: true, annotationItems: categoryLocations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Image("marker_" + location.type)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44)
                        .onTapGesture {
                            selectedPlace = location
                            showingSheet = true
                        }
                }
            }
            .sheet(isPresented: $showingSheet) {
                LocationDetails(location: selectedPlace)
            }
            
            if(mapModel.isLocationAvailable) {
                GoToMyLocationButton(mapCenterRegion: $mapCenterRegion,
                                     customEdgeInsets: EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 5))
            }
        }
    }
}
