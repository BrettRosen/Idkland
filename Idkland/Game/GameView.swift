//
//  GameView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import ComposableArchitecture
import SwiftUI

struct GameView: View {
    
    let store: Store<GameState, GameAction>
    
    @State private var position = CGPoint(x: screen.midX, y: screen.midY)
    
    var body: some View {
        WithViewStore(store) { viewStore in
            if viewStore.isLoading {
                BasicLoadingView()
                    .onAppear {
                        viewStore.send(.gameAppeared)
                    }
            } else {
                switch viewStore.screen {
                case .game:
                    ZStack {
                        BasicBackgroundView()
                        
                        ZStack {
                            ZoneView(store: self.store)
                            ZonePlayersView(store: self.store)
                            ActionBarView(store: self.store)
                        }
                        .blur(radius: viewStore.showSettings ? 5 : 0)
                        
                        if viewStore.showSettings {
                            SettingsView(store: self.store.scope(
                                state: \.settingsState,
                                action: GameAction.settingsAction
                            ))
                            .transition(.opacity)
                        }
                    }
                case .mapEditor:
                    MapEditorView(position: $position)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(store: gameStoreMock)
    }
}
