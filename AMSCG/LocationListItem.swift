//
//  LocationListView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 16.2.22..
//

import SwiftUI

struct LocationListItem: View {
    @EnvironmentObject var mapModel: MapViewModel
    
    let location: Location
    
    var body: some View {
        HStack() {
            Image(location.type)
                .resizable()
                .scaledToFit()
                .frame(width: 44)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
            
            VStack(alignment: .leading) {
                Text(LocalizedStringKey(location.type + "_singular"))
                    .font(.caption)
                    .foregroundColor(Color.grayTitle)
                Text(location.title)
                    .font(.headline)
                    .foregroundColor(Color.blueLightBlue)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            HStack {
                if(mapModel.isLocationAvailable) {
                    Text(location.coordinate.distanceString(to: mapModel.currentLocation.coordinate))
                        .font(.caption)
                        .foregroundColor(Color.blueLightBlue)
                        .fontWeight(.bold)
                }
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .foregroundColor(Color.chevron)
            }
        }
    }
}
