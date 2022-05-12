//
//  ServerConnectView.swift
//  Mobile
//
//  Created by user on 2022-04-19.
//

import SwiftUI

struct ServerConnectView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    @EnvironmentObject private var appSettings: AppSettings
    var body: some View {
        ZStack {
            Color.scheme.bg
            if (appSettings.isSignedIn) {
                MowerConnectView()
            }
            else {
                VStack {
                    Text("Enter Mower Address")
                        .font(.largeTitle)
                    //TextField("", text: $appSettings.serverAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .colorScheme(.light)
                        .padding()
                    Button(action: {
                        appSettings.isSignedIn = true
                    }) {
                        Text("Connect")
                            .frame(maxWidth: screenWidth * 0.5)
                            .frame(height: 48)
                    }
                    .buttonStyle(.bordered)
                }.padding()
            }
        }
    }
}

struct ServerConnectView_Previews: PreviewProvider {
    static var previews: some View {
        ServerConnectView()
    }
}
