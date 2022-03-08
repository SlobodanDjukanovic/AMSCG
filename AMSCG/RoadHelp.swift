//
//  RoadHelp.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 21.1.22..
//

import SwiftUI
import MapKit
import CoreLocationUI

struct RoadHelp: View {
    @EnvironmentObject var mapModel: MapViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @State var userTrackingMode = MapUserTrackingMode.follow
    @State var showClipboardNotification = false
    @State var locationInfo: LocalizedStringKey = LocalizedStringKey("")
    let phoneNumberCall = "19807"
    let phoneNumberSMS = "+38263239987"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Map(coordinateRegion: $mapModel.region, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: [mapModel.currentLocation]) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        if(mapModel.isLocationAvailable) {
                            ZStack {
                                Circle()
                                .background(Circle().fill(Color.blue))
                                .opacity(0.1)
                                Circle()
                                .strokeBorder(Color.blue, lineWidth: 1)
                            }
                            .frame(width: 64, height: 64)
                        }
                    }
                }
                .navigationTitle(LocalizedStringKey("road_assistance"))
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $networkMonitor.internetInfoAlert) {
                    Alert(title: Text(LocalizedStringKey("no_internet")),
                          message: Text(LocalizedStringKey("no_internet_detailed")),
                          dismissButton: .default(Text("OK")))
                }
            }
            .ignoresSafeArea()
            .overlay(CopyMyLocationButton(buttonLabel: LocalizedStringKey("copy_my_location"),
                                          locationInfo: $locationInfo,
                                          showClipboardNotification: $showClipboardNotification)
                        .alert(isPresented: $showClipboardNotification) {
                            Alert(title: Text(LocalizedStringKey("location_info")),
                                  message: Text(locationInfo),
                                  dismissButton: .default(Text("OK")))
                        },
                     alignment: .top)
            .overlay(
                HStack {
                    CallButton(phoneNumber: phoneNumberCall)
                    Spacer()
                    SMSButton(phoneNumber: phoneNumberSMS)
                }.frame(width: geometry.size.width * 0.5),
                alignment: .bottom)
            .overlay(GoToMyLocationButton(mapCenterRegion: $mapModel.region,
                                         customEdgeInsets: EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 4)),
                     alignment: .topTrailing)
        }
    }
}

struct RoadHelp_Previews: PreviewProvider {
    static var previews: some View {
        RoadHelp()
    }
}
