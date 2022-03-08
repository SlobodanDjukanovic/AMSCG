//
//  FuelPriceView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 24.2.22..
//

import SwiftUI

struct FuelPricesView: View {
    let urlString: String
    var title: LocalizedStringKey
    @State var errorMessage: String? = nil
    
    @State private var fuelPrices = [FuelPrice]()
    @State private var comment = ""
    
    var body: some View {
        if errorMessage == nil {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(fuelPrices, id: \.self) { item in
                            FuelPriceItem(fuelPrice: item)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 15))
                    
                    if(errorMessage != "") {
                        Text(comment)
                            .font(.body)
                            .foregroundColor(Color.blueLightBlue)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .modifier(ConditionalBackground())
            .onAppear() {
                Task {
                    await loadData()
                }
            }
        } else {
            Text(errorMessage!)
                .padding()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: urlString) else {
            self.errorMessage = "<h1>Invalid URL</h1>"
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(JSONFuelPrice.self, from: data) {
                fuelPrices = decodedResponse.data
                comment = decodedResponse.msg
            }
        } catch {
            self.errorMessage = "<h1>Invalid data</h1>"
        }
    }
}
