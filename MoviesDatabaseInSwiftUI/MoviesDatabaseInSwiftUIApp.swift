//
//  MoviesDatabaseInSwiftUIApp.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 15/7/23.
//

import SwiftUI

@main
struct MoviesDatabaseInSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
