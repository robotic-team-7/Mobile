//
//  AppSettings.swift
//  Mobile
//
//  Created by user on 2022-04-19.
//

import Foundation
class AppSettings: ObservableObject {
    @Published var username: String?
    @Published var authToken: String?
    @Published var mowerIsOn: Bool
    @Published var mowerIsBle: Bool
    @Published var isSignedIn: Bool
    @Published var loginAttemptStatusMessage: String

    init() {
        self.username = nil
        self.authToken = nil
        self.isSignedIn = false
        self.mowerIsOn = false
        self.mowerIsBle = false
        self.loginAttemptStatusMessage = ""
    }
}
