//
//  SettingsHomeMenu.swift
//  Idkland
//
//  Created by Brett Rosen on 7/10/20.
//

import ComposableArchitecture
import SwiftUI

struct SettingsHomeMenu: View {
    
    let store: Store<SettingsState, SettingsAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                if let user = Global.user, user.isAdmin() {
                    SettingsRowButton(title: "Map editor") {
                        viewStore.send(.mapEditorTapped)
                    }
                    
                    Divider()
                }
                
                SettingsRowButton(title: "Log out") {
                    viewStore.send(.logoutTapped)
                }
            }
        }
    }
}

struct SettingsHomeMenu_Previews: PreviewProvider {
    static var previews: some View {
        SettingsHomeMenu(store: Store(initialState: SettingsState(), reducer: settingsReducer, environment: SettingsEnvironment(client: .live)))
    }
}
