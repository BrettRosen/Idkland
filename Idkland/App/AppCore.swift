//
//  AppCore.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import Foundation

struct AppState: Equatable {
    var user: User?
    
    var isLoading = false

    var gameState = GameState()
    
    var showSignupModal = false
    var signupCoreState = SignupCoreState()
    
    var loginCoreState = LoginCoreState()
    var loginState: LoginState {
        get {
            LoginState(user: user, core: loginCoreState, showSignupModal: showSignupModal, signupCoreState: signupCoreState)
        } set {
            self.user = newValue.user
            self.loginCoreState = newValue.core
            self.showSignupModal = newValue.showSignupModal
            self.signupCoreState = newValue.signupCoreState
        }
    }
}

enum AppAction {
    case appAppeared
    case getSignedInUserResult(Result<User, NetworkingError>)
    
    case gameAction(GameAction)
    case loginAction(LoginAction)
}

struct AppEnvironment {
    var client: AppClient
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer.combine(
    Reducer { state, action, environment in
        switch action {
        case .appAppeared:
            state.isLoading = true
            return environment.client
                .getSignedInUser()
                .catchToEffect()
                .map(AppAction.getSignedInUserResult)
        case let .getSignedInUserResult(result):
            state.isLoading = false
            switch result {
            case let .success(user):
                state.user = user
                Global.user = user
                return .none
            case .failure:
                return .none
            }
        case .gameAction, .loginAction:
            return .none
        }
    },
    loginReducer.pullback(
        state: \.loginState,
        action: /AppAction.loginAction,
        environment: { _ in LoginEnvironment(client: .live) }
    ),
    gameReducer.pullback(
        state: \.gameState,
        action: /AppAction.gameAction,
        environment: { _ in GameEnvironment(client: .live) }
    )
)
