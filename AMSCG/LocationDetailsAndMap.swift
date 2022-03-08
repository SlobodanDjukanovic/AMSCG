//
//  LocationDetailsAndMap.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 17.2.22..
//

import SwiftUI
import MapKit

struct LocationDetailsAndMap: View {
    @EnvironmentObject var mapModel: MapViewModel
    let selectedLocation: Location
    @State private var tabSelection = 1

    var body: some View {
        let locationBinding = Binding<[Location]>(
            get: { [self.selectedLocation] },
            set: { _ in }
        )
        
        TabView (selection: $tabSelection) {
            LocationDetails(location: selectedLocation)
                .tabItem {
                    Image(systemName: "doc.text")
                    Text(LocalizedStringKey("info"))
                }
                .tag(1)
            LocationCategoryMap(mapCenterRegion: $mapModel.region, categoryLocations: locationBinding)
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text(LocalizedStringKey("map"))
                }
                .tag(2)
        }
        .font(.headline)
        .navigationTitle(selectedLocation.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            // This is to center the map on the selected location
            mapModel.region.center = CLLocationCoordinate2D(latitude: Double(selectedLocation.latitude) ?? 42.409723,
                                                            longitude: Double(selectedLocation.longitude) ?? 19.247722)
        }
    }
}
