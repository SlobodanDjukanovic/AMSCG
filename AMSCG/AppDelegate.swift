//
//  AppDelegate.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 18.1.22..
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        Thread.sleep(forTimeInterval: 1) // Increase launch screen time. Not the best solution:
        //https://stackoverflow.com/questions/43276199/how-can-i-delay-splash-launch-screen-programmatically-in-swift-xcode-ios
        // It is Not a good practice to put your application to sleep!
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        // This is to disable orientation change, i.e. to fix the portrait orientation
        return .portrait
    }
}
