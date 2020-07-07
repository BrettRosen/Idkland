//
//  ActionBarView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import SwiftUI

struct ActionBarView: View {
    
    let store: Store<GameState, GameAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button(action: {
                    withAnimation(.easeIn) {
                        viewStore.send(.toggleSettings(on: true))
                    }
                }) {
                    Text("⚙️")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: cellWidth, height: cellWidth)
                                .foregroundColor(Colors.accent.value)
                        )
                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                }
            }
        }
    }
}

struct ActionBarView_Previews: PreviewProvider {
    static var previews: some View {
        ActionBarView(store: Store(initialState: GameState(), reducer: gameReducer, environment: GameEnvironment(client: .live)))
    }
}
