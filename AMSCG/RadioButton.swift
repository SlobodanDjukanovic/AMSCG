//
//  RadioButton.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 7.2.22..
//

import SwiftUI

struct RadioButton: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(id: String, label: String, size: CGFloat = 20, color: Color = Color.black,
         textSize: CGFloat = 14, isMarked: Bool = false, callback: @escaping (String)->()) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack {
                label
                
                Spacer()
                
                Button {
                    configuration.isOn.toggle()
                } label: {
                    if configuration.isOn {
                        Image(systemName: "largecircle.fill.circle")
                            .foregroundColor(Color.blueAMSCG)
                    } else {
                        Image(systemName: "circle")
                            .foregroundColor(Color.blueAMSCG)
                    }
                }
                .imageScale(.large)
                .padding(5)
                .font(.title3)
            }
            
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}
