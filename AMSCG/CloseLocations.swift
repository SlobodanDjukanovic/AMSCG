//
//  CloseLocations.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 13.1.22..
//

import SwiftUI

struct CloseLocations: View {
    @EnvironmentObject var mapModel: MapViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    let routes: Routes
    let POIKeys = ["all_categories", "service", "parking", "garage", "bank", "police", "ambulance"]
    @State private var locations = [Location]()
    
    var body: some View {
        let POIroutes = [routes.poiAll, routes.poiServices, routes.poiParkings, routes.poiGarages,
                         routes.poiBanks, routes.poiPolice, routes.poiAmbulances]
        let withIndex = POIKeys.enumerated().map({$0})
        
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(withIndex, id: \.element) { index, key in
                        NavigationLink(destination: LocationCategory(locationsCategory: key,
                                                                     urlString: POIroutes[index],
                                                                     categoryFullName: LocalizedStringKey(key),
                                                                     locations: locations))
                        {
                            CloseLocationsListItem(imageName: key, imageWidth: geometry.size.width * 0.14)
                        }
                    }
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 15))
            }
        }
        .navigationTitle(LocalizedStringKey("close_to_me"))
        .navigationBarTitleDisplayMode(.inline)
        .modifier(ConditionalBackground())
        .onAppear() {
            mapModel.checkIfLocationServicesIsEnabled()
        }
    }
}
