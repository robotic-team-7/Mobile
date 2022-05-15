//
//  ApiModel.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-04-14.
//

import Foundation
import Combine
import SwiftUI

class ApiManager: ObservableObject {
    @Published var mowers = [Mower]()
    @Published var mower = [Mower]()
    @Published var mowingSessions = [MowingSession]()
    @Published var mowingSession = [MowingSession]()
    @Published var obstacles = [Obstacle]()
    @Published var serverAddress = "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080"
    private let authToken = ""
    
    func getMower(mowerId: String) {
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/user/mower/\(mowerId)" ) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { ( data, response, error ) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    self.mower = try JSONDecoder().decode([Mower].self, from: data)
                } catch {
                    print(error)
                }
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
                        appSettings.selectedMowerId = mowerId
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
    
    func getMowingSession(sessionId: Int) {
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

struct MowingSessionWithObstacles: Decodable, Identifiable {
    var mowingSessionId: Int
    var mowerPositions: MowerPositions
    var createdAt: String
    var mowerId: String
    var Obstacles: Obstacle
    var id:Int {
        mowingSessionId
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
