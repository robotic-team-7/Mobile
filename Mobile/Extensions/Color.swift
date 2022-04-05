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
    let accent = Color("Accent")
    let disabledAccent = Color("DisabledAccent")
    let background = Color("Background")
    let foreground = Color("Foreground")
    let disabledForeground = Color("DisabledForeground")
    let selected = Color("Selected")
}
