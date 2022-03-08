//
//  RoadConditionView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 18.2.22..
//

import SwiftUI

struct RoadWorksView: View {
    @EnvironmentObject var mapModel: MapViewModel
    let urlString: String
    @State private var roadConditionLocations = [RoadCondition]()
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            RoadWorksMap(mapCenterRegion: $mapModel.region, roadConditionLocations: $roadConditionLocations)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blueAMSCG))
                    .scaleEffect(1.5, anchor: .center)
            }
        }
        .font(.headline)
        .navigationTitle(LocalizedStringKey("road_works"))
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
            
            if let decodedResponse = try? JSONDecoder().decode(RoadConditions.self, from: data) {
                roadConditionLocations = decodedResponse.data
                isLoading = false
            }
        } catch {
            print("Invalid data")
        }
    }
}
