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
            if (appSettings.selectedMowerId != nil) {
                //SessionConnectView()
                NavView()
            }
            else if (createNewMower) {
                AddMowerView()
            }
            else {
                VStack {
                    List(apiManager.mowers) { mower in
                        Button(action: {
                            appSettings.selectedMowerId = mower.mowerId
                            print(appSettings.selectedMowerId!)
                        }){
                            Text(mower.mowerId)
                        }.listRowBackground(Color.scheme.darkBg)}
                    Spacer()
                    HStack {
                        Button(action: {
                            apiManager.getMowers()
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
                    apiManager.getMowers()
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
