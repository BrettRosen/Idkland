//
//  SettingsRowButton.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import SwiftUI

struct SettingsRowButton: View {
    
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .bold()
                .font(.body)
                .foregroundColor(Colors.primary.value)
        }
    }
}

struct SettingsRowButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowButton(title: "Log out", action: {})
    }
}
