//
//  HomeView.swift
//  Mobile
//
//  Created by user on 2022-04-04.
//

import SwiftUI
import SwiftKeychainWrapper

struct DashboardView: View {
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var apiManager: ApiManager
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.bg
                VStack {
                    // Status items for mower
                    HStack {
                        DashItem(title: "Status", text: "\(apiManager.mower.first?.status ?? "")", image: nil, progress: nil)
                        DashItem(title: "Mower", text: "\(apiManager.mower.first?.id ?? "")", image: nil,  progress: nil)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    // Status items for mowing session
                    if (!apiManager.mowingSession.isEmpty) {
                        HStack {
                            DashItem(title: "Obstacles", text: "\(apiManager.mowingSession.first!.Obstacles.count) detected", image: nil,  progress: nil)
                            // DashItem(title: "Time running", text: "3 detected", image: nil, progress: nil)
                        }.fixedSize(horizontal: false, vertical: true)
                    }
                    HStack {
                        VStack (alignment: .center) {
                            Text("Mode")
                                .font(.title3.bold())
                            HStack(alignment: .center) {
                                Button(action: {
                                    apiManager.setMowerStatus(mowerId: apiManager.mower.first!.mowerId, status: "stop", appSettings: self.appSettings)
                                }) {
                                    VStack {
                                        Image(systemName: "power")
                                            .frame(width: 48, height: 48)
                                            .background(Color.scheme.darkerFg)
                                            .clipShape(Circle())
                                        Text("Stop")
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(appSettings.mowerStop)
                                Button(action: {
                                    apiManager.setMowerStatus(mowerId: apiManager.mower.first!.mowerId, status: "start auto", appSettings: self.appSettings)
                                }) {
                                    VStack {
                                        Image(systemName: "bolt.fill")
                                            .frame(width: 48, height: 48)
                                            .background(Color.scheme.darkerFg)
                                            .clipShape(Circle())
                                        Text("Auto")
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(appSettings.mowerAuto)
                                
                                
                                Button(action: {
                                    apiManager.setMowerStatus(mowerId: apiManager.mower.first!.mowerId, status: "start bt", appSettings: self.appSettings)
                                    
                                }) {
                                    VStack {
                                        Image(systemName: "gamecontroller.fill")
                                            .frame(width: 48, height: 48)
                                            .background(Color.scheme.darkerFg)
                                            .clipShape(Circle())
                                        Text("Remote")
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(appSettings.mowerBle)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(10)
                        .background(Color.scheme.darkBg)
                        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                    }.fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    if (apiManager.mowingSession.isEmpty) {
                        VStack {
                            Text("Mowing Sessions")
                            List(apiManager.mowingSessions.reversed()) { mowingSession in
                                Button(action: {
                                    apiManager.getMowingSession(sessionId: mowingSession.mowingSessionId, appSettings: self.appSettings)
                                }){
                                    Text("Id: \(mowingSession.mowingSessionId) Date: \(mowingSession.createdAt)")
                                }.listRowBackground(Color.scheme.darkBg)}
                            Spacer()
                            HStack {
                                Button(action: {
                                    apiManager.getMowingSessions(mowerId: apiManager.mower.first!.mowerId, appSettings: self.appSettings)
                                }) {
                                    Text("Refresh")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 24)
                                }.buttonStyle(.bordered)
                                Button(action: {
                                    logOut()
                                }) {
                                    Text("Sign Out")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 24)
                                }.buttonStyle(.bordered)
                            }
                        }
                    }
                    else {
                        HStack {
                            Button(action: {
                                apiManager.mowingSession = []
                            }) {
                                Text("Close session")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 24)
                            }
                            .buttonStyle(.bordered)
                            Button(action: {
                                logOut()
                            }) {
                                Text("Sign Out")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 24)
                            }.buttonStyle(.bordered)
                        }
                    }
                }.padding(10)
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func logOut(){
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        apiManager.mowingSession = []
        apiManager.mowers = []
        apiManager.mowingSessions = []
        appSettings.mowerBle = false
        appSettings.mowerAuto = false
        appSettings.mowerStop = false
        appSettings.isSignedIn = false
    }
    
    // builder for reusable status item.
    @ViewBuilder
    func DashItem(title: String, text: String, image: String?, progress: CGFloat?)->some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.title3.bold())
            Spacer()
            HStack(alignment: .bottom) {
                Text(text)
                    .font(.caption2.bold())
                    .foregroundColor(.gray)
                
                Spacer()
                Image(systemName: image ?? "")
                    .frame(width: 32, height: 32)
                    .font(.title2)
                    .background(
                        ZStack {
                            if (progress != nil) {
                                Circle()
                                    .stroke(Color.scheme.darkerFg, lineWidth: 2)
                                Circle()
                                    .trim(from: 0, to: progress! / 100)
                                    .stroke(Color.scheme.fg, lineWidth: 2)
                            }
                        }
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(10)
        .background(Color.scheme.darkBg)
        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
    }
    
    struct DashboardView_Previews: PreviewProvider {
        static var previews: some View {
            DashboardView()
                .environmentObject(ApiManager())
                .environmentObject(AppSettings())
        }
    }
}
