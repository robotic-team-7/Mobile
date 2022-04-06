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
                Color.scheme.bg
                VStack {
                    Text("Enter Mower Address")
                        .font(.largeTitle)
                    HStack {
                        TextField("", text: $mowerAddress)
                            .padding(.top)
                            .background(Color.scheme.fg)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .padding(.bottom)
                    }
                    HStack(alignment: .center) {
                        Button(action: {
                            print("Starting Mowing!")
                        }) {
                            Text("Start")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .disabled(false)
                        .frame(maxWidth: .infinity)
                        
                        Button(action: {
                            print("Starting Mowing!")
                        }) {
                            Text("Start")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .disabled(true)
                        .frame(maxWidth: .infinity)
                    }
                }.padding()
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
