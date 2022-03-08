//
//  SetupView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 4.2.22..
//

import SwiftUI

struct AboutAppView: View {
    let phones = ["19807", "+38220234999", "+38263239987"]
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: Date())
    }
    
    let opacitySmallTitle = 0.7
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 10) {
                Image("logo_yellowBorder")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width * 0.66)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 5, trailing: 20))
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 15) {
                        Section(header: SectionHeader(title: LocalizedStringKey("terms_conditions"))) {
                            Text("terms_conditions_text")
                                .foregroundColor(Color.blueLightBlue)
                                .font(.system(size: 15))
                        }
                        
                        Section(header: SectionHeader(title: LocalizedStringKey("contact"))) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(LocalizedStringKey("address"))
                                    .foregroundColor(Color.grayTitle.opacity(opacitySmallTitle))
                                Text("Rimski trg 60, Podgorica")
                                    .foregroundColor(Color.blueLightBlue)
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text(LocalizedStringKey("phones"))
                                    .foregroundColor(Color.grayTitle.opacity(opacitySmallTitle))
                                HStack {
                                    ForEach(phones, id: \.self) { phone in
                                        Text(phone)
                                            .foregroundColor(.blue)
                                            .font(.system(size: 15))
                                            .onTapGesture {
                                                guard let url = URL(string: "tel://" + phone) else { return }
                                                UIApplication.shared.open(url)
                                            }
                                        Spacer()
                                    }
                                }
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text(LocalizedStringKey("working_hours_info"))
                                    .foregroundColor(Color.grayTitle.opacity(opacitySmallTitle))
                                Text("0-24h")
                                    .foregroundColor(Color.blueLightBlue)
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text(LocalizedStringKey("working_hours_management"))
                                    .foregroundColor(Color.grayTitle.opacity(opacitySmallTitle))
                                Text(LocalizedStringKey("working_hours_management_text"))
                                    .foregroundColor(Color.blueLightBlue)
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text(LocalizedStringKey("e_mail"))
                                    .foregroundColor(Color.grayTitle.opacity(opacitySmallTitle))
                                Text("amscg@t-com.me")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        let mailtoString = "mailto:amscg@t-com.me".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                        let mailtoUrl = URL(string: mailtoString!)!
                                        if UIApplication.shared.canOpenURL(mailtoUrl) {
                                            UIApplication.shared.open(mailtoUrl, options: [:])
                                        }
                                    }
                            }
                        }
                         
                        Section(header: SectionHeader(title: LocalizedStringKey("app_development"))) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(LocalizedStringKey("app_development_text"))
                                    .foregroundColor(Color.blueLightBlue)
                                Text("slobdj@gmail.com")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        let mailtoString = "mailto:slobdj@gmail.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                        let mailtoUrl = URL(string: mailtoString!)!
                                        if UIApplication.shared.canOpenURL(mailtoUrl) {
                                            UIApplication.shared.open(mailtoUrl, options: [:])
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 20, trailing: 15))
        }
        .navigationTitle(LocalizedStringKey("about_app"))
        .modifier(ConditionalBackground())
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
