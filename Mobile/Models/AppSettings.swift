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
    @Published var selectedMowerId: String?
    @Published var selectedSessionId: Int?
    @Published var autoMode: Bool
    @Published var isSignedIn: Bool

    init() {
        self.username = nil
        self.authToken = nil
        self.selectedMowerId = nil
        self.selectedSessionId = nil
        self.isSignedIn = false
        self.autoMode = false
    }
}
