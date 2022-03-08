//
//  ChargingStationsView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 17.2.22..
//

import SwiftUI

struct ChargingStationsView: View {
    @EnvironmentObject var mapModel: MapViewModel
    let urlString: String
    @State private var tabSelection = 1
    @State private var chargingLocations = [Location]()
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            TabView (selection: $tabSelection) {
                LocationCategoryList(categoryLocations: $chargingLocations)
                    .tabItem {
                        Image(systemName: "list.triangle")
                        Text(LocalizedStringKey("list"))
                    }
                    .tag(1)
                LocationCategoryMap(mapCenterRegion: $mapModel.region, categoryLocations: $chargingLocations)
                    .tabItem {
                        Image(systemName: "mappin.and.ellipse")
                        Text(LocalizedStringKey("map"))
                    }
                    .tag(2)
            }
            
            if isLoading {
                ZStack {
                    Color(.systemBackground)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blueAMSCG))
                        .scaleEffect(1.5, anchor: .center)
                }
            }
        }
        .font(.headline)
        .navigationTitle(LocalizedStringKey("closest_pumps"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            Task {
                await loadData()
            }
            mapModel.checkIfLocationServicesIsEnabled()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Locations.self, from: data) {
                chargingLocations = decodedResponse.data
                if(mapModel.isLocationAvailable) {
                    chargingLocations.sort(by: {$0.coordinate.distance(to: mapModel.myLocation) < $1.coordinate.distance(to: mapModel.myLocation)})
                }
                isLoading = false
            }
        } catch {
            print("Invalid data")
        }
    }
}
