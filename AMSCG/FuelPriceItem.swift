//
//  FuelPriceItem.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 24.2.22..
//

import SwiftUI

struct FuelPriceItem: View {
    let fuelPrice: FuelPrice
    
    var body: some View {
        HStack {
            Text(fuelPrice.name)
                .font(.headline)
                .foregroundColor(Color.blueLightBlue)
            
            Spacer()
            
            Text("\(fuelPrice.price) €")
                .font(.headline)
                .foregroundColor(Color.blueLightBlue)
        }
    }
}
