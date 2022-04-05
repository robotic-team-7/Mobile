//
//  NavView.swift
//  Mobile
//
//  Created by user on 2022-04-05.
//

import SwiftUI

struct NavView: View {
    
    // Applying navigation control theme
    init() {
        
        //        let tabAppearence = UITabBarAppearance()
        //        tabAppearence.backgroundColor = UIColor(Color.scheme.accent)
        //        tabAppearence.selectionIndicatorTintColor = UIColor(Color.scheme.selected)
        //        tabAppearence.configureWithOpaqueBackground()
        //        UITabBar.appearance().standardAppearance = tabAppearence
        UITabBar.appearance().backgroundColor = UIColor(Color.scheme.accent)
        UITabBar.appearance().tintColor = UIColor(Color.scheme.selected)
        UITabBar.appearance().barTintColor = UIColor(Color.scheme.accent)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.scheme.foreground)
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = UIColor(Color.scheme.accent)
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.scheme.foreground)]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.scheme.foreground)]
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().tintColor = UIColor(Color.scheme.accent)
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ConnectView()
                .tabItem {
                    Image(systemName: "point.3.filled.connected.trianglepath.dotted")
                    Text("Connect")
                }
            // Replace with actual views later on
            Text("Map")
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            Text("Gallery")
                .tabItem {
                    Image(systemName:"photo.fill")
                    Text("Gallery")
                }
        }
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}
