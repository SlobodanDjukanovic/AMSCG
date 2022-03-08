//
//  ChangeLanguageView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 5.2.22..
//

import SwiftUI

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}

struct ChangeLanguageView: View {
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-view-dismiss-itself
    @Environment(\.presentationMode) var presentation
    
    @Binding var language: String
    @State var checkedMNE = true
    
    var body: some View {
        VStack(spacing: 15) {
            Toggle(isOn: $checkedMNE) {
                HStack {
                    Image("mne")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 44)
                    Text("Crnogorski")
                }
            }
            .toggleStyle(CheckboxToggleStyle())
            .onChange(of: checkedMNE) {newValue in
                if(newValue == true) {
                    language = "sr-Latn-ME"
                } else {
                    language = "eng"
                }
                UserDefaults.standard.set(language, forKey: "lang")
                presentation.wrappedValue.dismiss()
            }
            
            Toggle(isOn: !$checkedMNE) {
                HStack {
                    Image("eng")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 44)
                    Text("English")
                }
            }
            .toggleStyle(CheckboxToggleStyle())
            
            Spacer()
        }
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
        .navigationTitle(LocalizedStringKey("choose_language"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            if(language != "sr-Latn-ME") {
                self.checkedMNE = false
            }
        }
        .modifier(ConditionalBackground())
    }
}
