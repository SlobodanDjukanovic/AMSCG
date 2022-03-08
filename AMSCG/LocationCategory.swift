//
//  LocationCategory.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 14.1.22..
//

import SwiftUI
import CoreLocation

struct LocationCategory: View {
    @EnvironmentObject var mapModel: MapViewModel
    let locationsCategory: String
    let urlString: String
    @State var categoryFullName: LocalizedStringKey
    @State var locations: [Location]
    @State private var tabSelection = 1
    @State private var isLoading = true
    
    var body: some View {
        // Kreiramo custom binding da bi computed property mogao da se prosledi kao binding
        let locationsBinding = Binding<[Location]> (
            get: { self.locations },
            set: { _ in }
        )
        ZStack {
            TabView (selection: $tabSelection) {
                LocationCategoryList(categoryLocations: locationsBinding)
                    .tabItem {
                        Image(systemName: "list.triangle")
                        Text(LocalizedStringKey("list"))
                    }
                    .tag(1)
                LocationCategoryMap(mapCenterRegion: $mapModel.region, categoryLocations: locationsBinding)
                    .tabItem {
                        Image(systemName: "mappin.and.ellipse")
                        Text(LocalizedStringKey("map"))
                    }
                    .tag(2)
            }
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blueAMSCG))
                    .scaleEffect(1.5, anchor: .center)
            }
        }
        .font(.headline)
        .navigationTitle(categoryFullName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            Task {
                await loadData()
            }
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
                locations = decodedResponse.data
                if(mapModel.isLocationAvailable) {
                    locations.sort(by: {$0.coordinate.distance(to: mapModel.myLocation) < $1.coordinate.distance(to: mapModel.myLocation)})
                }
                isLoading = false
            }
        } catch {
            print("Invalid data")
        }
    }
}
