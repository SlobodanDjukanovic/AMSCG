import SwiftUI
import CoreLocationUI

struct MyLocationButton: View {
    @EnvironmentObject var mapModel: MapViewModel
    @State var buttonLabel: String
    @Binding var locationInfo: String
    
    init(buttonLabel: String) {
        self.buttonLabel = buttonLabel
    }
    
    var body: some View {
        if(mapModel.isLocationAvailable) {
            Button {
                mapModel.goToMyLocation()
                
                //locationInfo =
                
                let pasteboard = UIPasteboard.general
                pasteboard.string = "Moj ga soro nacinio"
            } label: {
                Label(buttonLabel, systemImage: "location.fill")
            }
            .buttonStyle(.bordered)
            .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
        }
    }
}
