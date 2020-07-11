//
//  SettingsMapEditorMenu.swift
//  Idkland
//
//  Created by Brett Rosen on 7/10/20.
//

import ComposableArchitecture
import SwiftUI

struct SettingsMapEditorMenu: View {
    
    let store: Store<SettingsState, SettingsAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                SettingsRowButton(title: "Create map") {
                    
                }
                
                Divider()
                
                SettingsRowButton(title: "Load map") {
                    
                }
            }
        }
    }
}

struct SettingsMapEditorMenu_Previews: PreviewProvider {
    static var previews: some View {
        SettingsHomeMenu(store: Store(initialState: SettingsState(), reducer: settingsReducer, environment: SettingsEnvironment(client: .live)))
    }
}
