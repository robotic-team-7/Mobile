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
    @Published var mowers: [Mower] = []
    @Published var mower: [Mower] = []
    @Published var mowingSessions: [MowingSession] = []
    @Published var mowingSession: [MowingSession] = []
    @Published var obstacles: [Obstacle] = []
    @Published var serverAddress = "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080"
    private let authToken = "eyJraWQiOiJweW1jVm9UdmMxOVI4eTlmbnR2OFgwSkJOQ1wvZ1dyOXhoa3JGQXM0bUJ0RT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhNDA0ZGIwNi01NGE3LTQ3MTUtOWE2ZS05OWNmNmUxY2NmNGYiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuZXUtbm9ydGgtMS5hbWF6b25hd3MuY29tXC9ldS1ub3J0aC0xXzBVZDMwTEl3eiIsImNsaWVudF9pZCI6IjE5aW5yc2NiaGM0aGdycHM3ajMxbGo3Z2M1Iiwib3JpZ2luX2p0aSI6ImU4YjUxMzQ5LTY1OTEtNDVlOC05ZTZjLTM5MjViZTNmMzI1MyIsImV2ZW50X2lkIjoiODI3M2Q3MDctMzgzOS00NWFhLWFhMDgtZGRlZTY0YWQwNzliIiwidG9rZW5fdXNlIjoiYWNjZXNzIiwic2NvcGUiOiJhd3MuY29nbml0by5zaWduaW4udXNlci5hZG1pbiIsImF1dGhfdGltZSI6MTY1Mjc3NzAyMywiZXhwIjoxNjUyODYzNDIzLCJpYXQiOjE2NTI3NzcwMjMsImp0aSI6IjA3YTk5MDk4LTliMjItNGNhMS04ZTJhLTRjZDU2MjI0MmI4MCIsInVzZXJuYW1lIjoiYW5uaWVtaWtlbiJ9.Pu8N_zROWnmj7lLPsQtuhEJfzFLIHho0AvPvAXlyYSWrv189bePJuAmsG9AgnzdISKsxw9DtUeqr0xONwa6TV1ZDgdxxXIxEpVka5_-pkiHyVBEOnCY_Xm6HIevE2PX3geaVzSoeBLd-UeNZHkDj4bmdxA4gQwNm_ssoxkwqeTEFD00EOaKRdhCJSWZOd-gkjBxIWFsZcxVHn3s3QNnc7W0yQMiIx9hiE_cn8sUoZv_q4SGQ1kQpNuDvPhKdugDcMosEhppLx07MwTxh4MqGaIGNx-J25bwOvl18Oo2WJhqnOBNBXz5-hh6PjwIiWLeJVDzKc6J19ywPG16vHZb9yA"
    private let keychain = KeychainWrapper.standard

    func getMower(mowerId: String, appSettings: AppSettings) {
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/\(mowerId)" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
            case 200:
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    do {
                        self.mower = try JSONDecoder().decode([Mower].self, from: data)
                        let mowerStatus = self.mower.first!.status
                        if mowerStatus == "stop" {
                            appSettings.mowerIsOn = false
                            appSettings.mowerIsBle = false
                        }
                        else {
                            appSettings.mowerIsOn = true
                            if mowerStatus == "start manual" {
                                appSettings.mowerIsBle = true
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            case 401:
                print("Authentication Error")
            case 400..<500:
                print("Response Error")
            default:
                print(response.statusCode)
            }
        }.resume()
    }

    func getMowers(appSettings: AppSettings) {
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/user/mowers" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
            case 200:
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    do {
                        self.mowers = try JSONDecoder().decode([Mower].self, from: data)
                    } catch {
                        print(error)
                    }
                }
            case 401:
                print("Authentication Error")
            case 400..<500:
                print("Response Error")
            default:
                print(response.statusCode)
            }
        }.resume()
    }
    
    func addMower(mowerId: String, status: String, appSettings: AppSettings) {
        let json: [String: String] = ["mowerId": mowerId, "status": status]
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/mower" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
            case 201:
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    do {
                        // appSettings.selectedMowerId = mowerId
                        let str = try JSONDecoder().decode(String.self, from: data)
                        print(str)
                    } catch {
                        print(error)
                    }
                }
            case 401:
                print("Authentication Error")
            case 400..<500:
                print("Response Error")
            default:
                print(response.statusCode)
            }
        }.resume()
    }

    func setMowerStatus(mowerId: String, status: String, appSettings: AppSettings) {
        let json: [String: String] = ["status": status]
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/mower/\(mowerId)" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
            case 200:
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    do {
                        let success = try JSONDecoder().decode(Bool.self, from: data)
                        if (success){
                            self.getMower(mowerId: mowerId, appSettings: appSettings)
                        }
                    } catch {
                        print(error)
                    }
                }
            case 401:
                print("Authentication Error")
            case 400..<500:
                print("Response Error")
            default:
                print(response.statusCode)
            }
        }.resume()
    }
    
    func getMowingSessions(mowerId: String) {
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/mowingSessions/\(mowerId)" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
            case 200:
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    do {
                        self.mowingSessions = try JSONDecoder().decode([MowingSession].self, from: data)
                    } catch {
                        print(error)
                    }
                }
            case 401:
                print("Authentication Error")
            case 400..<500:
                print("Response Error")
            default:
                print(response.statusCode)
            }
        }.resume()
    }
    
    func getMowingSession(sessionId: Int, appSettings: AppSettings) {
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/mowingSession/\(sessionId)" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let response = response as? HTTPURLResponse else { return }
            switch response.statusCode {
            case 200:
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    do {
                        self.mowingSession = try JSONDecoder().decode([MowingSession].self, from: data)
                    } catch {
                        print(error)
                    }
                }
            case 401:
                print("Authentication Error")
            case 400..<500:
                print("Response Error")
            default:
                print(response.statusCode)
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
    var points: [CGFloat]
}

struct Mower: Decodable, Identifiable {
    var mowerId, userId, status: String
    var id: String {
        mowerId
    }
}

struct MowingSession: Decodable, Identifiable {
    var mowingSessionId: Int
    var mowerPositions: MowerPositions
    var createdAt: String
    var mowerId: String
    var Obstacles: [Obstacle]
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case mowingSessionId
        case mowerPositions
        case createdAt
        case mowerId
        case Obstacles
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mowingSessionId = try container.decode(Int.self, forKey: .mowingSessionId)
        mowerPositions = try container.decode(MowerPositions.self, forKey: .mowerPositions)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        mowerId = try container.decode(String.self, forKey: .mowerId)
        Obstacles = try container.decodeIfPresent([Obstacle].self, forKey: .Obstacles) ?? []
        id = try container.decode(Int.self, forKey: .mowingSessionId)
    }
}


struct Obstacle: Decodable, Identifiable {
    var obstacleId: Int
    var imagePath: String
    var obstaclePosition: [CGFloat]
    var imageClassification: String
    var id: Int {
        obstacleId
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
