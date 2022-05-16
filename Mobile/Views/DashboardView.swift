//
//  HomeView.swift
//  Mobile
//
//  Created by user on 2022-04-04.
//

import SwiftUI

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
                        DashItem(title: "Status", text: "\(apiManager.mower.description)", image: "togglepower", progress: nil)
                        DashItem(title: "Battery", text: "\(Double(apiManager.mower.capacity) / 100)", image: "bolt.square.fill",  progress: Double(apiManager.mower.capacity) / 100)
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
                        VStack (alignment: .leading) {
                            Text("Auto")
                                .font(.title3.bold())
                            Spacer()
                            Toggle(isOn: $appSettings.autoMode ){}
                                .labelsHidden()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.scheme.darkBg)
                        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                        DashItem(title: "Time running", text: "50 minutes", image: nil, progress: nil)
                    }.fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    if (appSettings.selectedSessionId != nil) {
                        Button(action: {
                            appSettings.selectedSessionId = nil
                        }) {
                            Text("Disconnect from session")
                                .frame(maxWidth: screenWidth * 0.5)
                                .frame(height: 48)
                        }
                        .buttonStyle(.bordered)
                        .disabled(false)
                    }
                    else {
                        VStack {
                            Text("Mowing Sessions")
                            List(apiManager.mowingSessions) { mowingSession in
                                Button(action: {
                                    appSettings.selectedSessionId = mowingSession.mowingSessionId
                                    apiManager.getMowingSession(sessionId: mowingSession.mowingSessionId, appSettings: self.appSettings)
                                }){
                                    Text("Id: \(mowingSession.mowingSessionId) Date: \(mowingSession.createdAt)")
                                }.listRowBackground(Color.scheme.darkBg)}
                            Spacer()
                            HStack {
                                Button(action: {
                                    apiManager.getMowingSessions(mowerId: appSettings.selectedMowerId!)
                                }) {
                                    Text("Refresh")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 24)
                                }.buttonStyle(.bordered)
                            }
                        }
                    }
                }.padding(10)
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
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
        }
    }
}
