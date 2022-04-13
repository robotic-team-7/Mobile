//
//  Line.swift
//  Mobile
//
//  Created by user on 2022-04-13.
//

import Foundation
import SwiftUI

struct Line: Identifiable {
    var points: [CGPoint]
    var linewidth: CGFloat
    var color: Color
    let id = UUID()
}
