//
//  RoadConditionAlert.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 18.2.22..
//

import SwiftUI

struct RoadConditionAlert: View {
    
    @Binding var shown: Bool
    let roadCondition: RoadCondition
    
    var body: some View {
        VStack {
            HStack {
                Image(roadCondition.type)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44)
                
                Text(roadCondition.title)
                    .foregroundColor(Color.white)
                    .font(.headline)
                
                Spacer()
                
                Button() {
                    shown.toggle()
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 24))
                        .foregroundColor(Color.red)
                }
            }
            
            Divider()
                .background(Color.white)
            
            ScrollView {
                Text(roadCondition.description)
                    .foregroundColor(Color.white)
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding(10)
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .clipped()
    }
}
