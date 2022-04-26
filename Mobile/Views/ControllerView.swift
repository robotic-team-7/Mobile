//
//  ControllerView.swift
//  Mobile
//
//  Created by user on 2022-04-21.
//

import SwiftUI

struct ControllerView: View {
    var body: some View {
        ZStack {
            Color.scheme.bg
                .ignoresSafeArea()
            VStack() {
                Spacer()
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "camera.fill")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                    }
                    .buttonStyle(.bordered)
                    Button(action: {
                    }) {
                        Image(systemName: "power")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                    }
                    .buttonStyle(.bordered)
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "arrowtriangle.up.fill")
                            .font(.largeTitle)
                            .frame(width: 48, height: 48)
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }
                HStack(alignment:.center) {
                    Button(action: {
                    }) {
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.largeTitle)
                            .frame(width: 48, height: 48)

                    }
                    .buttonStyle(.bordered)
                    //Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "")
                            .font(.largeTitle)
                            .frame(width: 48, height: 48)

                    }
                    .buttonStyle(.bordered)
                    .hidden()
                    Button(action: {
                    }) {
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.largeTitle)
                            .frame(width: 48, height: 48)
                    }
                    .buttonStyle(.bordered)
                }
                HStack {
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.largeTitle)
                            .frame(width: 48, height: 48)
                        
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }
                Spacer()
            }.padding()
        }
    }
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerView()
    }
}
