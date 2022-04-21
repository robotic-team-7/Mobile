//
//  ServerConfiguration.swift
//  Mobile
//
//  Created by user on 2022-04-19.
//

import Foundation
class ServerConfiguration: ObservableObject {
    @Published var serverAddress: String
    @Published var isConnected: Bool

    init(serverAddress: String, isConnected: Bool) {
        self.serverAddress = serverAddress
        self.isConnected = isConnected
    }
}
