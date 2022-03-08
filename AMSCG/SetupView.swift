//
//  SetupView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 4.2.22..
//

import SwiftUI

struct SetupView: View {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: Date())
    }
        
    var body: some View {
        VStack {
            Text("Today is:")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            Text(formattedDate)
                .font(.title2)
        }
        .navigationTitle("O aplikaciji")
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
