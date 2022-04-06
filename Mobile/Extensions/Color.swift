//
//  Color.swift
//  Mobile
//
//  Created by user on 2022-04-05.
//

import Foundation
import SwiftUI

extension Color {
    static let scheme = ColorScheme()
}

struct ColorScheme {
    let bg = Color("Background")
    let darkBg = Color("DarkBackground")
    let darkerBg = Color("DarkerBackground")
    let fg = Color("Foreground")
    let darkerFg = Color("DarkerForeground")
    let darkFg = Color("DarkForeground")
}
