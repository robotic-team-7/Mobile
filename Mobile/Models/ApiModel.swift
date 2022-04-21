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
        guard let url = URL(string: "http://212.25.136.76:8080/mobile/mowerPositions/1") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            let decodedData = try! JSONDecoder().decode([Mower].self, from: data)

            DispatchQueue.main.async {
                self.mower = decodedData
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
