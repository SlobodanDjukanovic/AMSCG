//
//  ButtonMyLocation.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 21.1.22..
//

import SwiftUI
import CoreLocationUI
import MapKit

struct TransparentButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(Color.transparentButtonBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct GoToMyLocationButton: View {
    @EnvironmentObject var mapModel: MapViewModel
    @Binding var mapCenterRegion: MKCoordinateRegion
    let customEdgeInsets: EdgeInsets
    
    var body: some View {
        Button {
            if(mapModel.isLocationAvailable) {
                mapCenterRegion.center = mapModel.myLocation
                mapModel.goToMyLocation()
            }
        } label: {
            if #available(iOS 15.0, *) {
                Image(systemName: "location.square.fill").font(.system(size: 40, weight: .medium))
                    .foregroundColor(Color.cyanMint)
            } else {
                Image(systemName: "location.circle.fill").font(.system(size: 40, weight: .medium))
                    .foregroundColor(Color.cyanMint)
            }
        }
        .padding(customEdgeInsets)
    }
}

struct CopyMyLocationButton: View {
    @EnvironmentObject var mapModel: MapViewModel
    @State var buttonLabel: LocalizedStringKey
    @Binding var locationInfo: LocalizedStringKey
    @Binding var showClipboardNotification: Bool
    
    init(buttonLabel: LocalizedStringKey, locationInfo: Binding<LocalizedStringKey>, showClipboardNotification: Binding<Bool>) {
        self.buttonLabel = buttonLabel
        self._locationInfo = locationInfo
        self._showClipboardNotification = showClipboardNotification
    }
    
    var body: some View {
        if(mapModel.isLocationAvailable) {
            Button {
                // mapModel.goToMyLocation()  // Prva realizacija, kad je dugme vracalo na tekucu lokaciju
                showClipboardNotification = true
                let locationString = """
                lat: \(String(format: "%.6f", mapModel.myLocation.latitude)), \
                lng: \(String(format: "%.6f", mapModel.myLocation.longitude))
                """
                locationInfo = LocalizedStringKey("location_copied\(locationString)")
                
                let pasteboard = UIPasteboard.general
                pasteboard.string = locationString
            } label: {
                Text(buttonLabel)
                //Label(buttonLabel, systemImage: "location.fill")  // Prva realizacija, kad je dugme imalo MyLocation ikonicu
            }
            .buttonStyle(TransparentButton())
            .foregroundColor(Color.transparentButtonForeground)
            .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
            
        }
    }
}


struct CallButton: View {
    @State var phoneNumber: String
    var formattedLabel: String {
        let remove: Set<Character> = [" ", "-"]
        var phone = phoneNumber
        phone.removeAll(where: { remove.contains($0) })
        return "tel://" + phone
    }
    
    var body: some View {
        Button(action: {
            guard let url = URL(string: formattedLabel) else { return }
            UIApplication.shared.open(url) }
        ) {
            Image(systemName: "phone.fill")
                .font(.system(size: 30))
        }
        .buttonStyle(TransparentButton())
        .foregroundColor(.red)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0))
    }
}


struct SMSButton: View {
    @EnvironmentObject var mapModel: MapViewModel
    @State var phoneNumber: String
    
    var fullSMS: String {
        let locationString = """
        lat: \(String(format: "%.6f", mapModel.myLocation.latitude)), \
        lng: \(String(format: "%.6f", mapModel.myLocation.longitude))
        """
        let smsFull = "sms:" + phoneNumber + "&body=" + locationString
        return smsFull.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    var body: some View {
        Button(action: {
            guard let url = URL(string: fullSMS) else { return }
            UIApplication.shared.open(url) }
        ) {
            Image(systemName: "text.bubble.fill")
                .font(.system(size: 30))
        }
        .buttonStyle(TransparentButton())
        .foregroundColor(.red)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0))
    }
}
