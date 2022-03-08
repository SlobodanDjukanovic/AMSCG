//
//  RoadConditionMap.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 18.2.22..
//

import SwiftUI
import MapKit

struct RoadWorksMap: View {
    @EnvironmentObject var mapModel: MapViewModel
    
    @State private var selectedPlace: RoadCondition = RoadCondition.example
    @Binding var mapCenterRegion: MKCoordinateRegion
    @Binding var roadConditionLocations: [RoadCondition]
    @State private var showInfo = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                Map(coordinateRegion: $mapCenterRegion, showsUserLocation: true, annotationItems: roadConditionLocations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Image("marker_" + location.type)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                            .onTapGesture {
                                selectedPlace = location
                                showInfo = true
                            }
                    }
                }
                if(mapModel.isLocationAvailable) {
                    GoToMyLocationButton(mapCenterRegion: $mapCenterRegion,
                                         customEdgeInsets: EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 5))
                }
                
                if showInfo {
                    RoadConditionAlert(shown: $showInfo, roadCondition: selectedPlace)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.45, alignment: .bottom)
                }
            }
        }
    }
}
