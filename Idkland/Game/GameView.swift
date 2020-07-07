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
                        Colors.background.value.edgesIgnoringSafeArea(.all)
                        
                        ZoneView(store: self.store)
                            .blur(radius: viewStore.showSettings ? 5 : 0)

                        VStack {
                            Spacer()
                            ActionBarView(store: self.store)
                        }
                        
                        Text("😁")
                            .position(self.position)
                            .animation(.spring())
                            .edgesIgnoringSafeArea(.all)
                        
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
        GameView(store: Store(initialState: GameState(), reducer: gameReducer, environment: GameEnvironment(client: .live)))
    }
}
