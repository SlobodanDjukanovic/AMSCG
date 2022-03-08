//
//  CustomToggleStyle.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 5.2.22..
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .foregroundColor(Color.blueLightBlue)
            
            Spacer()
            
            Button {
                if !configuration.isOn {
                    configuration.isOn.toggle()
                }
            } label: {
                if configuration.isOn {
                    Image(systemName: "largecircle.fill.circle")
                        .foregroundColor(Color.blueLightBlue)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(Color.blueLightBlue)
                }
            }
            .imageScale(.large)
            .padding(5)
            .font(.title3)
        }
    }
}
