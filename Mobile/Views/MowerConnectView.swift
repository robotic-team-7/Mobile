//
//  MowerConnectView.swift
//  Mobile
//
//  Created by user on 2022-05-09.
//

import SwiftUI

struct MowerConnectView: View {
    init() {
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
    }
    
    let screenWidth = UIScreen.main.bounds.size.width
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var apiManager: ApiManager
    @State var createNewMower = false
    var body: some View {
        ZStack {
            Color.scheme.bg
            if (!apiManager.mower.isEmpty) {
                NavView()
            }
            else if (createNewMower) {
                AddMowerView()
            }
            else {
                VStack {
                    List(apiManager.mowers) { mower in
                        Button(action: {
                            apiManager.getMower(mowerId: mower.mowerId, appSettings: self.appSettings)
                        }){
                            Text(mower.mowerId)
                        }.listRowBackground(Color.scheme.darkBg)}
                    Spacer()
                    HStack {
                        Button(action: {
                            apiManager.getMowers(appSettings: self.appSettings)
                        }) {
                            Text("Refresh")
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                        }.buttonStyle(.bordered)
                        Button(action: {
                            createNewMower = true
                        }) {
                            Text("New Mower")
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                        }.buttonStyle(.bordered)
                    }
                }
                .padding()
                .onAppear(){
                    apiManager.getMowers(appSettings: self.appSettings)
                }
            }
        }
    }
}

struct MowerConnectView_Previews: PreviewProvider {
    static var previews: some View {
        MowerConnectView()
    }
}
