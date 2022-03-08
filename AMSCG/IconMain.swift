//
//  IconMain.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 2.2.22..
//

import SwiftUI

struct IconMain: View {
    @State var imageName: String
    @State var buttonText: LocalizedStringKey
    @State var imageWidth: CGFloat
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageWidth)
                .padding()

            Text(buttonText)
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
    }
}

struct IconMain_Previews: PreviewProvider {
    static var previews: some View {
        IconMain(imageName: "road_assistance", buttonText: "Pomoć na putu", imageWidth: 120)
    }
}
