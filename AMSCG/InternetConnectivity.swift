//
//  InternetConnectivity.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 19.1.22..
//

import Network

final class InternetConnectivity {
    var monitor = NWPathMonitor()
    @Published var isInternetAvailable = checkInternetConnectivity()
    
    func checkInternetConnectivity() -> Bool {
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                return false
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        return true
    }
}
