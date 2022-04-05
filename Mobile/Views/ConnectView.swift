//
//  ConnectView.swift
//  Mobile
//
//  Created by user on 2022-04-05.
//

import SwiftUI

struct ConnectView: View {
    
    @State private var mowerAddress: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.background.ignoresSafeArea()
                VStack {
                    Text("Enter Mower Address")
                        .font(.largeTitle)
                        .foregroundColor(Color.scheme.foreground)
                    HStack {
                        TextField("", text: $mowerAddress)
                            .padding()
                            .background(Color.scheme.foreground)
                            .foregroundColor(.black)
                            .cornerRadius(12) /// corner radius immediately after the background
                            .padding() /// extra padding outside the background
                    }
                    HStack(alignment: .center) {
                        Button(action: {
                            print("Starting Mowing!")
                        }) {
                            Text("Start")
                                .foregroundColor(Color.scheme.foreground)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.leading)
                        .buttonStyle(.bordered)
                        .tint(Color.scheme.foreground)
                        .disabled(false)
                        .frame(maxWidth: .infinity)
                        
                        Button(action: {
                            print("Starting Mowing!")
                        }) {
                            Text("Start")
                                .foregroundColor(Color.scheme.disabledForeground)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(Color.scheme.disabledForeground)
                        .disabled(true)
                        .frame(maxWidth: .infinity)
                        .padding(.trailing)
                    }
                }
            }
            .navigationTitle("Mower Connection")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct ConnectView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectView()
    }
}
