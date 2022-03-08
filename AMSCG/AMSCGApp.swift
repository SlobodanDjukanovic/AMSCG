//
//  AMSCGApp.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 13.1.22..
//

import SwiftUI

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}

@main
struct AMSCGApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var localIdentifier = UserDefaults.standard.string(forKey: "lang") ?? "sr-Latn-ME"
    var mapModel = MapViewModel()
    var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            ContentView(language: $localIdentifier)
                .environment(\.locale, .init(identifier: localIdentifier))
                .environmentObject(mapModel)
                .environmentObject(networkMonitor)
        }
    }
}
