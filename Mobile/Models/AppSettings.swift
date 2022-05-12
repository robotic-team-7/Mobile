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
    @Published var isMowerSelected: Bool
    @Published var isSessionSelected: Bool
    @Published var isSignedIn: Bool

    init() {
        self.username = nil
        self.authToken = nil
        self.selectedMowerId = nil
        self.selectedSessionId = nil
        self.isMowerSelected = false
        self.isSessionSelected = false
        self.isSignedIn = false
    }
}
