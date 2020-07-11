//
//  SettingsView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
    
    let store: Store<SettingsState, SettingsAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {                
                Colors.clear.value.edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            viewStore.send(.backgroundTapped)
                        }
                    }
                
                switch viewStore.settingsScreen {
                case .home:
                    SettingsHomeMenu(store: self.store)
                        .modifier(SettingsMenuModifier())
                        .transition(.opacity)
                case .mapEditor:
                    SettingsMapEditorMenu(store: self.store)
                        .modifier(SettingsMenuModifier())
                        .transition(.opacity)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(store: Store(initialState: SettingsState(), reducer: settingsReducer, environment: SettingsEnvironment(client: .live)))
    }
}
