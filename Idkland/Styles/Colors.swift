//
//  Colors.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import Foundation
import SwiftUI

enum Colors {
    case
    alert,
    background,
    primary,
    secondary,
    accent,
    clear
     
    var value: Color {
        switch self {
        case .background: return Color("background")
        case .primary: return Color("primary")
        case .secondary: return Color("secondary")
        case .accent: return Color("accent")
        case .alert: return Color("alert")
        case .clear: return Color.primary.opacity(0.0001)
        }
    }
}
