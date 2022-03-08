//
//  RoadConditionListView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 22.2.22..
//

import SwiftUI

struct RoadConditionListItem: View, Hashable {
    let imageName: String
    let title: LocalizedStringKey
    
    var body: some View {
        HStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 44)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
            
            HStack {
                Text(title)
                    .foregroundColor(Color.blueLightBlue)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .foregroundColor(Color.chevron)
            }
        }
    }
    
    // We have to implement this function to conform to Hashable
    // https://www.hackingwithswift.com/example-code/language/how-to-conform-to-the-hashable-protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageName)
    }
}
