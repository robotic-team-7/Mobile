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
    @Published var mowingSessions = [MowingSession]()
    @Published var obstacles = [Obstacle]()
    @Published var serverAddress = "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080"
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
