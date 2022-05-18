//
//  NavView.swift
//  Mobile
//
//  Created by user on 2022-04-05.
//

import SwiftUI
import SwiftKeychainWrapper

struct NavView: View {
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var apiManager: ApiManager
    // Applying navigation control theme
    init() {
        // Setting tabbar appearance
        UITabBar.appearance().backgroundColor = UIColor(Color.scheme.darkBg)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.scheme.darkerFg)
        // Setting navigationbar appearance
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = UIColor(Color.scheme.darkBg)
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.scheme.fg)]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.scheme.fg)]
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
    }

    var body: some View {
        if (!appSettings.isSignedIn) {
            SignInView()
        }
        else if (apiManager.mower.isEmpty) {
            MowerConnectView()
        }
        else {
            TabView {
                DashboardView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Dashboard")
                    }
                ControllerView()
                    .tabItem {
                        Image(systemName: "gamecontroller.fill")
                        Text("Remote")
                    }
                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                GalleryView()
                    .tabItem {
                        Image(systemName:"photo.fill")
                        Text("Gallery")
                    }
            }
        }
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
            .environmentObject(ApiManager())
            .environmentObject(AppSettings())
    }
}
