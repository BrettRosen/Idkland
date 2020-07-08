//
//  ZonePlayersView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/7/20.
//

import ComposableArchitecture
import SwiftUI

struct ZonePlayersView: View {
    
    let store: Store<GameState, GameAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                ForEachStore(
                    self.store.scope(state: \.lightPlayers, action: GameAction.lightPlayerAt(index:action:)),
                    content: PlayerView.init(store:)
                )
                
                IfLetStore(self.store.scope(
                    state: \.myLightPlayer,
                    action: GameAction.lightPlayer
                )) { store in
                    PlayerView(store: store)
                }
            }
        }
    }
}

struct ZonePlayersView_Previews: PreviewProvider {
    static var previews: some View {
        ZonePlayersView(store: gameStoreMock)
    }
}
