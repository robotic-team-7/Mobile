//
//  ApiModel.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-04-14.
//

import Foundation
import Combine
import SwiftUI

class API: ObservableObject {
    @Published var mower: [Mower] = []
    
    
    func getMower() {
        // Fetches mower
        guard let url = URL(string: "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decodedData = try! JSONDecoder().decode([Mower].self, from: data)

            DispatchQueue.main.async {
                self.mower = decodedData
            }
        }.resume()
    }
    
    func signIn(username: String, password: String) {
        guard let url = URL(string: "http://ec2-54-227-56-79.compute-1.amazonaws.com:8080/auth/sign-in") else { return }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let jsonDictionary: [String: String] = [
            "username": username,
            "password": password
        ]
        let data = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
        
        URLSession.shared.uploadTask(with: request, from: data) { (responseData, response, error) in
            if error != nil { return }
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                guard responseCode == 200 else { return }
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("Response JSON data = \(responseJSONData)")
                }
            }
        }.resume()
    }
}

struct MowerPositions: Decodable, Equatable {
    var points: [[CGFloat]]
}

struct Mower: Decodable, Identifiable {
    var positionsId: Int
    var mowerPositions: MowerPositions
    var createdAt: String
    var mowerId: Int
    
    var id: Int {
        positionsId
    }
}
