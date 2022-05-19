//
//  MowerConnectView.swift
//  Mobile
//
//  Created by user on 2022-05-09.
//

import SwiftUI
import SwiftKeychainWrapper

struct MowerConnectView: View {
    init() {
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
    }
    
    let screenWidth = UIScreen.main.bounds.size.width
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var apiManager: ApiManager
    @State var createNewMower = false
    @State var mowerName = ""
    var body: some View {
        ZStack {
            Color.scheme.bg
            if (createNewMower) {
                VStack {
                    Text("Enter mower name")
                        .font(.largeTitle)
                    TextField("", text: $mowerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .colorScheme(.light)
                        .padding()
                    Spacer()
                    HStack {
                        Button(action: {
                            apiManager.addMower(mowerId: mowerName, status: "stop", appSettings: self.appSettings)
                            createNewMower = false
                        }) {
                            Text("Add")
                                .frame(maxWidth: .infinity)
                                .frame(height: 24)
                        }.buttonStyle(.bordered)
                        Button(action: {
                            createNewMower = false
                        }) {
                            Text("List")
                                .frame(maxWidth: .infinity)
                                .frame(height: 24)
                        }.buttonStyle(.bordered)
                    }
                }.padding()
            }
            else {
                VStack {
                    List(apiManager.mowers) { mower in
                        Button(action: {
                            apiManager.getMower(mowerId: mower.mowerId, appSettings: self.appSettings)
                            apiManager.getMowingSessions(mowerId: mower.mowerId, appSettings: self.appSettings)
                        }){
                            Text(mower.mowerId)
                        }.listRowBackground(Color.scheme.darkBg)}
                    Spacer()
                    HStack {
                        Button(action: {
                            apiManager.getMowers(appSettings: self.appSettings)
                            appSettings.isSignedIn = false
                        }) {
                            Text("Refresh")
                                .frame(maxWidth: .infinity)
                                .frame(height: 24)
                        }.buttonStyle(.bordered)
                        Button(action: {
                            createNewMower = true
                        }) {
                            Text("New Mower")
                                .frame(maxWidth: .infinity)
                                .frame(height: 24)
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
            .environmentObject(ApiManager())
            .environmentObject(AppSettings())
    }
}
