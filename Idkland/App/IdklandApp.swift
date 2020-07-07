//
//  IdklandApp.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import ComposableArchitecture
import Firebase
import SwiftUI

@main
struct IdklandApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppState(), reducer: appReducer, environment: AppEnvironment(client: .live)))
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
