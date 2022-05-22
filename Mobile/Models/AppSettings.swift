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
    @Published var mowerAuto: Bool
    @Published var mowerBle: Bool
    @Published var mowerStop: Bool
    @Published var isSignedIn: Bool
    @Published var loginAttemptStatusMessage: String

    init() {
        self.username = nil
        self.authToken = nil
        self.isSignedIn = false
        self.mowerAuto = false
        self.mowerStop = false
        self.mowerBle = false
        self.loginAttemptStatusMessage = ""
    }
}
