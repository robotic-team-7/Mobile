//
//  AddMowerView.swift
//  Mobile
//
//  Created by user on 2022-05-12.
//

import SwiftUI

struct AddMowerView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var apiManager: ApiManager
    @State var mowerName = ""
    var body: some View {
        ZStack {
            Color.scheme.bg
            if (appSettings.selectedMowerId != nil) {
                NavView()
            }
            else {
                VStack {
                    Text("Enter mower name")
                        .font(.largeTitle)
                    TextField("", text: $mowerName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .colorScheme(.light)
                        .padding()
                    Button(action: {
                        apiManager.addMower(mowerId: mowerName, status: "start auto", appSettings: self.appSettings)
                    }) {
                        Text("Add")
                            .frame(maxWidth: screenWidth * 0.5)
                            .frame(height: 48)
                    }
                    .buttonStyle(.bordered)
                }.padding()
            }
        }
    }
}

struct AddMowerView_Previews: PreviewProvider {
    static var previews: some View {
        AddMowerView()
    }
}
