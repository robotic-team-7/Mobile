//
//  NavView.swift
//  Mobile
//
//  Created by user on 2022-04-05.
//

import SwiftUI

struct NavView: View {
    @EnvironmentObject private var serverConfiguration: ServerConfiguration
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
        if (!serverConfiguration.isConnected) {
            ServerConnectView()
        }
        else {
            TabView {
                DashboardView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Dashboard")
                    }
                ConnectView()
                    .tabItem {
                        Image(systemName: "point.3.filled.connected.trianglepath.dotted")
                        Text("Connect")
                    }
                // Replace with actual views later on
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
    }
}
