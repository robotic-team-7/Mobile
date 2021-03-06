//
//  MobileApp.swift
//  Mobile
//
//  Created by user on 2022-03-30.
//

import SwiftUI

@main
struct MobileApp: App {
    var body: some Scene {
        WindowGroup {
            // Starting with splash screen.
            // Setting default colorscheme to dark for easer consistency.
            SplashView()
                .preferredColorScheme(.dark)
                .environmentObject(AppSettings())
                .environmentObject(ApiManager())
        }
    }
}
