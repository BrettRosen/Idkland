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
        map: Array.init(repeating: Row(tiles: Array.init(repeating: Tile(hexColor: "32CD32", zoneObject: .mock ), count: Zone.columns)), count: Zone.rows)
    )
    
    var body: some View {
        WithViewStore(store) { viewStore in
            GridStack { row, col in
                Button(action: {
                    viewStore.send(.tappedZoneAt(row: row, col: col))
                }) {
                    Rectangle()
                        .frame(width: cellWidth, height: cellHeight)
                        .foregroundColor(zone.getTileColor(at: row, col: col))
                        .overlay(
                            Text(zone.getZoneObject(at: row, col: col)?.asset ?? "")
                                .font(.largeTitle)
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 0)
                        )
                }
            }
        }
    }
}

struct ZoneView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneView(store: gameStoreMock)
    }
}
