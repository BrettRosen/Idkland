//
//  LoginCore.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import Foundation

struct LoginState: Equatable {
    var user: User?
    var core = LoginCoreState()
    
    var showSignupModal = false

    var signupCoreState = SignupCoreState()
    var signupState: SignupState {
        get {
            SignupState(user: user, showSignupModal: showSignupModal, core: signupCoreState)
        } set {
            self.user = newValue.user
            self.showSignupModal = newValue.showSignupModal
            self.signupCoreState = newValue.core
        }
    }
}

struct LoginCoreState: Equatable {
    var emailError = ""
    var passwordError = ""
    var isLoading = false
}

enum LoginAction {
    case loginTapped(email: String, password: String)
    case loginResult(Result<User, NetworkingError>)
    
    case toggleSignupModal(on: Bool)
    case signupAction(SignupAction)
}

struct LoginEnvironment {
    var client: LoginClient
}

let loginReducer: Reducer<LoginState, LoginAction, LoginEnvironment> = Reducer.combine(
    Reducer { state, action, environment in
        switch action {
        case let .loginTapped(email, password):
            state.core.isLoading = true
            state.core.emailError = ""
            state.core.passwordError = ""
            
            var canLogin = true
            if email.isEmpty {
                state.core.emailError = "Please enter your email address"
                canLogin = false
            }
            if password.isEmpty {
                state.core.passwordError = "Please enter your password"
                canLogin = false
            }
            
            if canLogin {
                return environment.client
                    .login(email, password)
                    .catchToEffect()
                    .map(LoginAction.loginResult)
            } else {
                state.core.isLoading = false
                return .none
            }
        case let .loginResult(result):
            state.core.isLoading = false
            switch result {
            case let .success(user):
                Global.user = user
                state.user = user
            case .failure:
                state.core.emailError = "Incorrect email or password"
            }
            return .none
        case .signupAction:
            return .none
        case let .toggleSignupModal(on):
            state.showSignupModal = on
            return .none
        }
    },
    signupReducer.pullback(
        state: \.signupState,
        action: /LoginAction.signupAction,
        environment: { _ in SignupEnvironment(client: .live) }
    )
)



