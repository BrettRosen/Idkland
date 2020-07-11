//
//  SettingsCore.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import Foundation

enum SettingsScreen {
    case home
    case mapEditor
}

struct SettingsState: Equatable {
    var showSettings = false
    var settingsScreen: SettingsScreen = .home
    var screen: GameScreen = .game
}

enum SettingsAction {
    case logoutTapped
    case logoutResult(Result<Success, NetworkingError>)
    
    case mapEditorTapped
    
    case backgroundTapped
}

struct SettingsEnvironment {
    var client: SettingsClient
}

let settingsReducer: Reducer<SettingsState, SettingsAction, SettingsEnvironment> = Reducer.combine(
    Reducer { state, action, environment in
        switch action {
        case .mapEditorTapped:
            state.settingsScreen = .mapEditor
            return .none
        case .backgroundTapped:
            state.showSettings = false
            return .none
        case .logoutTapped:
            return environment.client
                .logout()
                .catchToEffect()
                .map(SettingsAction.logoutResult)
        case .logoutResult:
            return .none
        }
    }
)
