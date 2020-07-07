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
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Colors.accent.value)
                )
                .padding()
                .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0, y: 15)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(store: Store(initialState: SettingsState(), reducer: settingsReducer, environment: SettingsEnvironment(client: .live)))
    }
}
