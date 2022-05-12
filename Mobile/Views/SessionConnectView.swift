//
//  SessionConnectView.swift
//  Mobile
//
//  Created by user on 2022-05-11.
//

import SwiftUI

struct SessionConnectView: View {
    init() {
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
    }
    let screenWidth = UIScreen.main.bounds.size.width
    @EnvironmentObject private var appSettings: AppSettings
    @ObservedObject var apiManager = ApiManager()

    var body: some View {
        ZStack {
            Color.scheme.bg
            if (appSettings.isSessionSelected) {
                NavView()
            }
            else {
                VStack {
                    List(apiManager.mowingSessions) { mowingSession in
                        Button(action: {
                            appSettings.isSessionSelected = true
                            appSettings.selectedSessionId = mowingSession.mowingSessionId
                        }){
                            HStack {
                                Text(String(mowingSession.mowingSessionId))
                                Spacer()
                                Text(mowingSession.createdAt)
                            }
                        }.listRowBackground(Color.scheme.darkBg)}
                    Spacer()
                    HStack {
                        Button(action: {
                            apiManager.getMowingSessions()
                        }) {
                            Text("Refresh")
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                        }.buttonStyle(.bordered)
                        Button(action: {
                            // bleManager.disconnectPeripheral()
                        }) {
                            Text("New Mower")
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                        }.buttonStyle(.bordered)
                    }
                }.padding()
            }
        }
    }
}

struct SessionConnectView_Previews: PreviewProvider {
    static var previews: some View {
        SessionConnectView()
    }
}
