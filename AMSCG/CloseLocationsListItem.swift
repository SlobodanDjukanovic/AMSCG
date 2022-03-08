//
//  CloseLocationsListItem.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 25.2.22..
//

import SwiftUI

struct CloseLocationsListItem: View {
    let imageName: String
    let imageWidth: CGFloat
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            Text(LocalizedStringKey(imageName))
                .foregroundColor(Color.blueLightBlue)
            
            Spacer()
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(Color.chevron)
        }
    }
}
