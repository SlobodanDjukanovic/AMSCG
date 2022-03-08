//
//  RoadConditionList.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 22.2.22..
//

import SwiftUI

struct RoadConditionView: View {
    
    let roadConditions: [RoadConditionListItem] =
    [RoadConditionListItem(imageName: "congestion", title: LocalizedStringKey("current_condition")),
     RoadConditionListItem(imageName: "heavy_vehicles", title: LocalizedStringKey("restriction_cargo")),
     RoadConditionListItem(imageName: "caution", title: LocalizedStringKey("driver_advices"))]
    
    let routes = ["https://slobodan.ucg.ac.me/amscg/roadCondition.php",
                  "https://slobodan.ucg.ac.me/amscg/roadCondition.php",
                  "https://slobodan.ucg.ac.me/amscg/roadCondition.php"]
    
    var body: some View {
        let withIndex = roadConditions.enumerated().map({$0})
        
        if #available(iOS 15.0, *) {
            List(withIndex, id: \.element.imageName) { index, roadCondition in
                NavigationLink {
                    HTMLViewLoad(urlString: routes[index], title: LocalizedStringKey("road_condition"))
                } label: {
                    roadCondition
                }
                .listRowInsets(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 10))
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        } else {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(withIndex, id: \.element.imageName) { index, roadCondition in
                        NavigationLink {
                            HTMLViewLoad(urlString: routes[index], title: LocalizedStringKey("road_condition"))
                        } label: {
                            roadCondition
                        }
                    }
                    .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 15))
            }
        }
    }
}

struct RoadConditionList_Previews: PreviewProvider {
    static var previews: some View {
        RoadConditionView()
    }
}
