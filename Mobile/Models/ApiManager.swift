//
//  ApiModel.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-04-14.
//

import Foundation
import Combine
import SwiftUI
import SwiftKeychainWrapper

class ApiManager: ObservableObject {
    @Published var mowers = [Mower]()
    @Published var mowingSessions = [MowingSession]()
    @Published var obstacles = [Obstacle]()
    @Published var serverAddress = "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080"
    private let keychain = KeychainWrapper.standard
    
    private let authToken = ""
    init() {
        getMowers()
        getMowingSessions()
    }
    func getMower() {
        // Fetches mower
        guard let url = URL(string: "http://212.25.136.76:8080/mobile/mowerPositions/1") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decodedData = try! JSONDecoder().decode([Mower].self, from: data)
            DispatchQueue.main.async {
                self.mowers = decodedData
            }
        }.resume()
    }

    func getMowers() {
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/user/mowers" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    self.mowers = try JSONDecoder().decode([Mower].self, from: data)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    func getMowingSessions() {
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/mowingSessions/mobile" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    self.mowingSessions = try JSONDecoder().decode([MowingSession].self, from: data)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func signIn(username: String, password: String, appSettings: AppSettings) async {
        guard let url = URL(string: "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/auth/sign-in") else { return }
            
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let jsonDictionary: [String: String] = [
            "username": username,
            "password": password
        ]
        let encodedData = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: encodedData)
            
            if let responseCode = (response as? HTTPURLResponse)?.statusCode {
                // Login failed - NotAuthorizedException
                if responseCode == 400 {
                    let decodedData = try! JSONDecoder().decode(LoginFailed.self, from: data)
                    DispatchQueue.main.async {
                        appSettings.loginAttemptStatusMessage = "Username or password was incorrect"
                        appSettings.isSignedIn = false
                    }
                    print(decodedData)
                }
                // Login successful
                else if responseCode == 200 {
                    let decodedData = try! JSONDecoder().decode(LoginSuccessful.self, from: data)
                    keychain.set(decodedData.accessToken, forKey: "accessToken")
                    DispatchQueue.main.async {
                        appSettings.loginAttemptStatusMessage = "Login successful"
                        appSettings.isSignedIn = true
                    }
                }
            }
        } catch {
            print("Something went wrong.")
        }
    }
}

struct MowerPositions: Decodable, Equatable {
    var points: [[CGFloat]]
}

struct ObstaclePosition: Decodable, Equatable {
    var points: [[CGFloat]]
}

struct Mower: Decodable, Identifiable {
    var mowerId, userId, status: String
    var id: String {
        mowerId
    }
}

struct Obstacle: Decodable, Identifiable {
    var obstacleId: Int
    var userId: String
    var imageClassification: String
    var obstaclePosition: ObstaclePosition
    var imagePath: String
    var mowingSessionId: Int

    var id: Int {
        obstacleId
    }
}

struct MowingSession: Decodable, Identifiable {
    let mowingSessionId: Int
    let mowerPositions: MowerPositions
    let createdAt: String
    let mowerId: Int
    var id:Int {
        mowingSessionId
    }
}

struct LoginFailed: Decodable {
    let message: String
    let code: String
    let time: String
    let requestId: String
    let statusCode: Int
    let retryable: Bool
    let retryDelay: Double
}

struct LoginSuccessful: Decodable {
    let accessToken: String
    let email: String
    let username: String
    let name: String
    let family_name: String
}
