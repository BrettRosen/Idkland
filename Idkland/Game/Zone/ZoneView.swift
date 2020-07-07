//
//  ZoneView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/6/20.
//

import ComposableArchitecture
import SwiftUI

struct ZoneView: View {
    
    let store: Store<GameState, GameAction>
    
    let zone = Zone(
        name: "Test Zone",
        map: Array.init(repeating: Row(cells: Array.init(repeating: Cell(asset: "🏢"), count: Zone.columns)), count: Zone.rows)
    )
    
    var body: some View {
        GridStack { row, col in
            Button(action: {
                
            }) {
                Text("\(self.zone.getAsset(at: row, col: col))")
                    .font(.title)
            }
        }
    }
}

struct ZoneView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneView(store: Store(initialState: GameState(), reducer: gameReducer, environment: GameEnvironment(client: .live)))
    }
}
