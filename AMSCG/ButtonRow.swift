//
//  ButtonRow.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 14.1.22..
//

import SwiftUI

struct ButtonRow: View {
    @Binding var destinations: [View]
    @Binding var images: [String]
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: {}) {
                NavigationLink(destination: destinations[0]) {
                    Image(systemName: images[0])
                        .imageScale(.large)
                }
            }
            Spacer()
            Button(action: {}) {
                NavigationLink(destination: destinations[1]) {
                    Image(systemName: images[1])
                        .imageScale(.large)
                }
            }
            Spacer()
            Button(action: {}) {
                NavigationLink(destination: destinations[2]) {
                    Image(systemName: images[2])
                        .imageScale(.large)
                }
            }
            Spacer()
        }
        .padding()
    }
}
