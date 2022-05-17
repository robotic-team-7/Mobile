//
//  SplashView.swift
//  Mobile
//
//  Created by user on 2022-04-04.
//

import SwiftUI
struct SplashView: View {
    @State var isActive:Bool = false
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var apiManager: ApiManager
    var body: some View {
        ZStack {
            Color.scheme.bg
                .ignoresSafeArea()
            VStack {
                if self.isActive {
                    NavView()
                } else {
                    Text("Lawnmower 9000")
                        .font(Font.largeTitle)
                        .onAppear{
                            apiManager.getMowers(appSettings: self.appSettings)
                        }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
