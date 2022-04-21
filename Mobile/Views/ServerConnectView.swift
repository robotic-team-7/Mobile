//
//  ServerConnectView.swift
//  Mobile
//
//  Created by user on 2022-04-19.
//

import SwiftUI

struct ServerConnectView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    @EnvironmentObject private var serverConfiguration: ServerConfiguration
    var body: some View {
        ZStack {
            Color.scheme.bg
            if (serverConfiguration.isConnected) {
                NavView()
            }
            else {
                VStack {
                    Text("Enter Mower Address")
                        .font(.largeTitle)
                    TextField("", text: $serverConfiguration.serverAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .colorScheme(.light)
                        .padding()
                    Button(action: {
                        serverConfiguration.isConnected = true
                    }) {
                        Text("Connect")
                            .frame(maxWidth: screenWidth * 0.5)
                            .frame(height: 48)
                    }
                    .buttonStyle(.bordered)
                    .disabled(false)
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
