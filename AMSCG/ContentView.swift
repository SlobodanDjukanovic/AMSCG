//
//  ContentView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 13.1.22..
//

import SwiftUI

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

struct ContentView: View {
    @Binding var language: String
    
    @EnvironmentObject var mapModel: MapViewModel
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @State var showAppInfo = false
    @State var changeLanguage = false
    
    let imageWidthRatio = 0.19
    
    var body: some View {
        let routes = Routes(language: $language)
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.blueAMSCG
                    VStack() {
                        Spacer()
                        HStack(alignment: .top) {
                            Spacer()
                            
                            NavigationLink {
                                RoadHelp()
                            } label: {
                                IconMain(imageName: "road_assistance",
                                         buttonText: LocalizedStringKey("road_assistance"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                RoadConditionView(routes: routes)
                            } label: {
                                IconMain(imageName: "road_condition",
                                         buttonText: LocalizedStringKey("road_condition"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                RoadWorksView(urlString: routes.roadWorks)
                            } label: {
                                IconMain(imageName: "road_works",
                                         buttonText: LocalizedStringKey("road_works"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack(alignment: .top) {
                            
                            Spacer()
                            
                            NavigationLink {
                                ChargingStationsView(urlString: routes.stationsChargers)
                            } label: {
                                IconMain(imageName: "closest_pumps",
                                         buttonText: LocalizedStringKey("closest_pumps"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                CloseLocations(routes: routes)
                            } label: {
                                IconMain(imageName: "close_to_me",
                                         buttonText: LocalizedStringKey("close_to_me"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                FuelPricesView(urlString: routes.fuelPrices, title: LocalizedStringKey("fuel_prices"))
                            } label: {
                                IconMain(imageName: "fuel_prices",
                                         buttonText: LocalizedStringKey("fuel_prices"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack(alignment: .top) {
                            
                            Spacer()
                            
                            NavigationLink {
                                HTMLViewLoad(urlString: routes.tolls, title: LocalizedStringKey("tolls"))
                            } label: {
                                IconMain(imageName: "tolls",
                                         buttonText: LocalizedStringKey("tolls"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                HTMLViewLoad(urlString: routes.internationalDocuments, title: LocalizedStringKey("international_license"))
                            } label: {
                                IconMain(imageName: "international_license",
                                         buttonText: LocalizedStringKey("international_license"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                            
                            NavigationLink {
                                HTMLViewLoad(urlString: routes.borders, title: LocalizedStringKey("borders_cameras"))
                            } label: {
                                IconMain(imageName: "borders_cameras",
                                         buttonText: LocalizedStringKey("borders_cameras"),
                                         imageWidth: geometry.size.width * imageWidthRatio)
                            }
                            
                            Spacer()
                        }
                        Spacer()
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Image(systemName: "cloud.sun")
                                    .onTapGesture {
                                        if let url = URL(string: routes.meteo) {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                    .foregroundColor(Color.blueAMSCG)
                                    .padding(.trailing)
                                
                                Image(systemName: "phone")
                                    .onTapGesture {
                                        guard let urlPhone = URL(string: "tel://19807") else { return }
                                        UIApplication.shared.open(urlPhone)
                                    }
                                    .foregroundColor(Color.blueAMSCG)
                                    .padding(.trailing)
                                
                                Menu {
                                    Button {
                                        showAppInfo = true
                                    } label: {
                                        Label(LocalizedStringKey("about_app"), systemImage: "info.circle")
                                    }
                                    
                                    Button {
                                        changeLanguage = true
                                    } label: {
                                        Label(LocalizedStringKey("app_language"), systemImage: "globe")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                        .foregroundColor(Color.blueAMSCG)
                                }
                                .background (
                                    VStack {
                                        NavigationLink("", isActive: $showAppInfo) {
                                            AboutAppView()
                                        }
                                        NavigationLink("", isActive: $changeLanguage) {
                                            ChangeLanguageView(language: $language)
                                        }
                                    }
                                )
                            }
                        }
                    }
                )
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationAppearance(backgroundColor: UIColor(Color.yellowAMSCG),
                                  foregroundColor: UIColor(Color.blueAMSCG),
                                  tintColor: UIColor(Color.blueAMSCG),
                                  hideSeparator: true)
            .onAppear() {
                mapModel.checkIfLocationServicesIsEnabled()
            }
            .alert(isPresented: $networkMonitor.internetInfoAlert) {
                Alert(title: Text(LocalizedStringKey("no_internet")),
                      message: Text(LocalizedStringKey("no_internet_detailed")),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let lang = Binding<String> (
            get: {return "sr-Latn-ME"},
            set: {_ in }
        )
        return ContentView(language: lang)
    }
}
