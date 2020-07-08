//
//  PlayerCore.swift
//  Idkland
//
//  Created by Brett Rosen on 7/7/20.
//

import ComposableArchitecture
import Foundation

enum LightPlayerAction {
    case something
}

struct LightPlayerEnvironment {
    
}

let lightPlayerReducer: Reducer<LightPlayer, LightPlayerAction, LightPlayerEnvironment> = Reducer.combine(
    Reducer { state, action, environment in
        switch action {
        case .something: return .none
        }
    }
)
