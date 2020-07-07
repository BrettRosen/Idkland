//
//  AppView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                if viewStore.isLoading {
                    BasicLoadingView()
                } else if viewStore.user == nil {
                    LoginView(store: self.store.scope(
                        state: \.loginState,
                        action: AppAction.loginAction
                    ))
                    .transition(.opacity)
                } else {
                    GameView(store: self.store.scope(
                        state: \.gameState,
                        action: AppAction.gameAction
                    ))
                    .transition(.opacity)
                }
            }
            .onAppear {
                viewStore.send(.appAppeared)
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: Store(initialState: AppState(), reducer: appReducer, environment: AppEnvironment(client: .live)))
    }
}
