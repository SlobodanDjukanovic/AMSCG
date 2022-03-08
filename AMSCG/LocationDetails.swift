//
//  LocationDetails.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 15.1.22..
//

import SwiftUI
import MapKit

struct SectionHeader: View {
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
        .font(.title3)
        .textCase(.uppercase)
        .foregroundColor(Color.grayTitle)
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 15, leading: 0, bottom: 10, trailing: 0))
    }
}

struct LocationDetails: View {
    @EnvironmentObject var mapModel: MapViewModel
    
    let location: Location
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Section(header: SectionHeader(title: LocalizedStringKey("general_info"))) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(location.title)
                            .font(.headline)
                            .foregroundColor(Color.blueLightBlue)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(LocalizedStringKey("category"))
                                .foregroundColor(Color.grayTitle)
                            Text(LocalizedStringKey(location.type + "_singular"))
                                .foregroundColor(Color.blueLightBlue)
                        }
                        
                        if(mapModel.isLocationAvailable) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(LocalizedStringKey("location_distance"))
                                    .foregroundColor(Color.grayTitle)
                                Text(location.coordinate.distanceString(to: mapModel.currentLocation.coordinate))
                                    .foregroundColor(Color.blueLightBlue)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(LocalizedStringKey("location_description"))
                                .foregroundColor(Color.grayTitle)
                            Text(location.description)
                                .foregroundColor(Color.blueLightBlue)
                        }
                    }
                    .font(.body)
                }
                
                if(location.address != "" || location.web != "" || location.phone != "") {
                    Section(header: SectionHeader(title: LocalizedStringKey("contact_info"))) {
                        VStack(alignment: .leading, spacing: 15) {
                            if(location.address != "") {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(LocalizedStringKey("address"))
                                        .foregroundColor(Color.grayTitle)
                                    Text(location.address)
                                        .foregroundColor(Color.blueLightBlue)
                                }
                            }
                            if(location.phone != "") {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(LocalizedStringKey("phone"))
                                        .foregroundColor(Color.grayTitle)
                                    Text(location.phone)
                                        .foregroundColor(Color.blueLightBlue)
                                }
                            }
                            if(location.web != "") {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(LocalizedStringKey("web"))
                                        .foregroundColor(Color.grayTitle)
                                    Text(location.web)
                                        .foregroundColor(Color.blueLightBlue)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .modifier(ConditionalBackground())
    }
}
