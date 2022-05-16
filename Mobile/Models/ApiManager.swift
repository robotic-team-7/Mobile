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
    @Published var mowers: [Mower] = []
    @Published var mower: [Mower] = []
    @Published var mowingSessions: [MowingSession] = []
    @Published var mowingSession: [MowingSession] = []
    @Published var obstacles: [Obstacle] = []
    @Published var serverAddress = "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080"
    private let authToken = "eyJraWQiOiJweW1jVm9UdmMxOVI4eTlmbnR2OFgwSkJOQ1wvZ1dyOXhoa3JGQXM0bUJ0RT0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhNDA0ZGIwNi01NGE3LTQ3MTUtOWE2ZS05OWNmNmUxY2NmNGYiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuZXUtbm9ydGgtMS5hbWF6b25hd3MuY29tXC9ldS1ub3J0aC0xXzBVZDMwTEl3eiIsImNsaWVudF9pZCI6IjE5aW5yc2NiaGM0aGdycHM3ajMxbGo3Z2M1Iiwib3JpZ2luX2p0aSI6IjhkY2FmNWQwLTkxOTMtNDI2NS1hODY0LWQ2MGE3Y2RjMDY4OSIsImV2ZW50X2lkIjoiOWExMjNmN2YtMDBkMy00ZjNlLWI2NDEtZjhlMjRkNjdlYTg3IiwidG9rZW5fdXNlIjoiYWNjZXNzIiwic2NvcGUiOiJhd3MuY29nbml0by5zaWduaW4udXNlci5hZG1pbiIsImF1dGhfdGltZSI6MTY1MjY5MzcxOCwiZXhwIjoxNjUyNzgwMTE4LCJpYXQiOjE2NTI2OTM3MTgsImp0aSI6ImIyNTZiZjJjLTJhMzQtNGNlNC04NmI2LTc1MzIxOGU1NDY5YiIsInVzZXJuYW1lIjoiYW5uaWVtaWtlbiJ9.axgVxKgikmvlc_us62iZUu6zYvFpNjfKbTQN9gDLisRyUVDlh0_Lm2BauFhoZUU_10f2aDf33zHVUcUe38e67zL4XNux9KYG2gHi_-O9r4E7V3yblPrvIaspC0UspL5xJowM8X4-36sZtHvsPe8Ag_DachJDqabj-t6B60houwSSLTQH3Qe7rEEc1v1y0yLliVfx0bX_CZV4uGhZqTaeGXllmqQF7mjPGjaxoHQY_dhAi_XoxvyHBBj0rIhmqmbGyMm3koyPpwjAMhy_-a_ACpJuXU_oK58_6hNU0r-mdjIQeeLN5XYDLDjgpbFDyn4tHSr7nZzTUnDydMHWTBuxYg"
    
    func getMower(mowerId: String) {
        guard let url = URL(string:  "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/mobile/user/mower/\(mowerId)" ) else { return }
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

    func getMowers() {
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
                        appSettings.selectedSessionId = sessionId
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
    var imagePath: String
    var obstaclePosition: [CGFloat]
    var imageClassification: String
    var id: Int {
        obstacleId
    }
}
