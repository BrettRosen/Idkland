//
//  GameCore.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import ComposableArchitecture
import Foundation

enum GameScreen {
    case game
    case mapEditor
}

struct GameState: Equatable {
    var screen: GameScreen = .game
    var isLoading = true
    
    var zone: Zone?
    
    var myLightPlayer: LightPlayer?
    var lightPlayers = [LightPlayer]()
    
    var showSettings = false
    var settingsScreen: SettingsScreen = .home
    var settingsState: SettingsState {
        get {
            SettingsState(showSettings: showSettings, settingsScreen: settingsScreen, screen: screen)
        } set {
            self.showSettings = newValue.showSettings
            self.settingsScreen = newValue.settingsScreen
            self.screen = newValue.screen
        }
    }
}

enum GameAction {
    case gameAppeared
    
    case getOrAddLightPlayerResult(Result<LightPlayer, NetworkingError>)
    case streamLightPlayersResult(Result<[LightPlayer], NetworkingError>)
    case updateLightPlayerResult(Result<Success, NetworkingError>)
    
    case tappedZoneAt(row: Int, col: Int)

    // Hooks to other Store actions
    case lightPlayerAt(index: Int, action: LightPlayerAction)
    case lightPlayer(LightPlayerAction)
    
    case toggleSettings(on: Bool)
    case settingsAction(SettingsAction)
}

struct GameEnvironment {
    var client: GameClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let gameReducer: Reducer<GameState, GameAction, GameEnvironment> = Reducer.combine(
    Reducer { state, action, environment in
        switch action {
        case let .tappedZoneAt(row, col):
            guard let _ = state.myLightPlayer else { return .none }
            
            /*
             let object = state.currentZone.getObject(at: row, col)
             let components = object.components
             // DialogComponent
             // ZoneTransferComponent
             
             for component in components {
                switch component {
                case let .dialog(text):
                    state.dialogText = text
                case let .zoneTransfer():
                    
                }
             }
             */
            
            state.myLightPlayer!.zonePosition = ZonePosition(row: row, col: col)

            return environment.client
                .updateLightPlayer(state.myLightPlayer!)
                .catchToEffect()
                .debounce(id: DebounceID(), for: 1.0, scheduler: environment.mainQueue)
                .map(GameAction.updateLightPlayerResult)
        case let .toggleSettings(on):
            if on { state.settingsScreen = .home }
            state.showSettings = on
            return .none
        case .gameAppeared:
            state.isLoading = true
            
            guard let user = Global.user else {
                return .none
            }
            
            return environment.client
                .getOrAddLightPlayer(user)
                .catchToEffect()
                .map(GameAction.getOrAddLightPlayerResult)
        case .updateLightPlayerResult:
            return .none
        case let .getOrAddLightPlayerResult(result):
            switch result {
            case let .success(lightPlayer):
                state.myLightPlayer = lightPlayer
                return environment.client
                    .streamLightPlayers(lightPlayer.zoneId)
                    .catchToEffect()
                    .map(GameAction.streamLightPlayersResult)
            case .failure:
                return .none
            }
        case let .streamLightPlayersResult(result):
            switch result {
            case let .success(lightPlayers):
                state.isLoading = false
                // Filter out the player's id so we don't see duplicates in-game
                state.lightPlayers = lightPlayers.filter { $0.id != state.myLightPlayer?.id }
                return .none
            case .failure:
                return .none
            }
        case .settingsAction, .lightPlayer, .lightPlayerAt:
            return .none
        }
    },
    settingsReducer.pullback(
        state: \.settingsState,
        action: /GameAction.settingsAction,
        environment: { _ in SettingsEnvironment(client: .live) }
    ),
    lightPlayerReducer.forEach(
      state: \.lightPlayers,
      action: /GameAction.lightPlayerAt(index:action:),
      environment: { _ in LightPlayerEnvironment() }
    )
)

let gameStoreMock = Store(initialState: GameState(), reducer: gameReducer, environment: GameEnvironment(client: .live, mainQueue: .init(DispatchQueue.main.eraseToAnyScheduler())))
