//
//  NetworkMonitor.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 20.1.22..
//

import Foundation
import Network
import SwiftUI


class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    @Published var isConnected = false
    @Published var internetInfoAlert = false

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            // Monitor runs on a background thread so we need to publish on the main thread
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    //print("We're connected!")
                    self.isConnected = true
                    self.internetInfoAlert = false
                } else {
                    //print("No connection.")
                    self.isConnected = false
                    self.internetInfoAlert = true
                }
            }
        }
        monitor.start(queue: queue)
    }
}
