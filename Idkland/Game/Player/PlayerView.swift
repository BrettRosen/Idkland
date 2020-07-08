//
//  PlayerView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/7/20.
//

import ComposableArchitecture
import SwiftUI

struct PlayerView: View {
    
    let store: Store<LightPlayer, LightPlayerAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text(viewStore.asset)
                .position(viewStore.zonePosition.getGlobalPosition())
                .animation(.spring())
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(store: Store(initialState: .mock, reducer: lightPlayerReducer, environment: LightPlayerEnvironment()))
    }
}
