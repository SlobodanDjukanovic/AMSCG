//
//  LocationCategoryList.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 15.1.22..
//

import SwiftUI

struct ConditionalBackground: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        if(colorScheme == .dark) {
            content
                .background(Color.blueAMSCG)
        } else {
            content
        }
    }
}

struct LocationCategoryList: View {
    @Binding var categoryLocations: [Location]
    @EnvironmentObject var mapModel: MapViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(categoryLocations, id: \.self) { item in
                    NavigationLink {
                        LocationDetailsAndMap(selectedLocation: item)
                    } label: {
                        LocationListItem(location: item)
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
        .modifier(ConditionalBackground())
    }
}
