//
//  RoadConditionList.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 22.2.22..
//

import SwiftUI

struct RoadConditionView: View {
    let routes: Routes
    
    var body: some View {
        let roadConditionRoutes = [routes.currRoadCond,
                                   routes.heavyVehicles,
                                   routes.advices]
        let roadConditions: [RoadConditionListItem] = [
            RoadConditionListItem(imageName: "congestion", title: LocalizedStringKey("current_condition")),
            RoadConditionListItem(imageName: "heavy_vehicles", title: LocalizedStringKey("restriction_cargo")),
            RoadConditionListItem(imageName: "caution", title: LocalizedStringKey("driver_advices"))]
        let withIndex = roadConditions.enumerated().map({$0})
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(withIndex, id: \.element.imageName) { index, roadCondition in
                    NavigationLink {
                        HTMLViewLoad(urlString: roadConditionRoutes[index], title: roadCondition.title)
                    } label: {
                        roadCondition
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
        }
        .navigationBarTitle(LocalizedStringKey("road_condition"))
        .navigationBarTitleDisplayMode(.inline)
        .modifier(ConditionalBackground())
    }
}
