//
//  SettingsMenuModifier.swift
//  Idkland
//
//  Created by Brett Rosen on 7/10/20.
//

import Foundation
import SwiftUI

struct SettingsMenuModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Colors.accent.value)
            )
            .padding()
            .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0, y: 15)
    }
}
