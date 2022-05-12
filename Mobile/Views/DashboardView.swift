//
//  HomeView.swift
//  Mobile
//
//  Created by user on 2022-04-04.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var appSettings: AppSettings
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.bg
                VStack {
                    ScrollView {
                        HStack {
                            DashItem(title: "Status", text: "Running", image: "togglepower", progress: nil)
                            DashItem(title: "Battery", text: "20%", image: "bolt.square.fill",  progress: 20)
                        }.fixedSize(horizontal: false, vertical: true)
                        HStack {
                            DashItem(title: "Obstacles", text: "25 avoided", image: nil,  progress: nil)
                            DashItem(title: "Collissions", text: "3 detected", image: nil, progress: nil)
                        }.fixedSize(horizontal: false, vertical: true)
                        HStack {
                            VStack (alignment: .leading) {
                                Text("Power")
                                    .font(.title3.bold())
                                Spacer()
                                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/){}
                                    .labelsHidden()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(10)
                            .background(Color.scheme.darkBg)
                            .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                            DashItem(title: "Time running", text: "50 minutes", image: nil, progress: nil)
                        }.fixedSize(horizontal: false, vertical: true)
                    }
                    // Text("Connected to backend")
                    Button(action: {
                        appSettings.isSessionSelected = false
                    }) {
                        Text("Disconnect")
                            .frame(maxWidth: screenWidth * 0.5)
                            .frame(height: 48)
                    }
                    .buttonStyle(.bordered)
                    .disabled(false)
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
