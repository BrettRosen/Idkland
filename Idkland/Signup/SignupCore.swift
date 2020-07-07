//
//  SignupCore.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import Foundation

struct SignupState: Equatable {
    var user: User?
    var showSignupModal = false
    var core = SignupCoreState()
}

struct SignupCoreState: Equatable {
    var usernameError = ""
    var emailError = ""
    var passwordError = ""
    var isLoading = false
}

enum SignupAction {
    case signupTapped(username: String, email: String, password: String)
    case signupResult(Result<User, NetworkingError>)
}

struct SignupEnvironment {
    var client: SignupClient
}

let signupReducer: Reducer<SignupState, SignupAction, SignupEnvironment> = Reducer.combine(
    Reducer { state, action, environment in
        switch action {
        case let .signupTapped(username, email, password):
            var canSignup = true
            var lowercasedUsername = username.lowercased()
            state.core.isLoading = true
            state.core.usernameError = ""
            state.core.emailError = ""
            state.core.passwordError = ""
            
            if let error = validateUsername(lowercasedUsername) {
                canSignup = false
                state.core.usernameError = error
            }
            
            if let error = validateEmail(email) {
                canSignup = false
                state.core.emailError = error
            }
            
            if let error = validatePassword(password) {
                canSignup = false
                state.core.passwordError = error
            }
            
            if canSignup {
                return environment.client
                    .signup(lowercasedUsername, email, password)
                    .catchToEffect()
                    .map(SignupAction.signupResult)
            } else {
                state.core.isLoading = false
                return .none
            }
        case let .signupResult(result):
            state.core.isLoading = false
            switch result {
            case let .success(user):
                Global.user = user
                state.user = user
                state.showSignupModal = false
                return .none
            case .failure:
                state.core.usernameError = "There was an error signing up"
                return .none
            }
        }
    }
)

private func validateUsername(_ username: String) -> String? {
    let alphaNumericRegex = "^[a-zA-Z]+[a-zA-Z0-9]*$"
    let isAlpha = "^[a-zA-Z]+$"
    let minCharacters = 2
    let maxCharacters = 20
    
    if username.count < minCharacters {
        return "Username must be more than \(minCharacters) characters"
    } else if username.count > maxCharacters {
        return "Username must be less than \(maxCharacters) characters"
    } else if !"\(username.first!)".matches(isAlpha) {
        return "Username must start with a letter"
    } else if !username.matches(alphaNumericRegex) {
        return "Username contains invalid characters"
    } else {
        return nil
    }
}

private func validateEmail(_ email: String) -> String? {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", regex)
    if emailPred.evaluate(with: email) {
        return nil
    } else {
        return "Please enter a valid email"
    }
}

private func validatePassword(_ password: String) -> String? {
    let oneLowercaseRegex = "(?=.*[a-z])"
    let oneUppercaseRegex = "(?=.*[A-Z])"
    let oneNumberRegex = "(?=.*[0-9])"
    let oneSpecialCharRegex = "(?=.[@$!%#?&])"
    
    let minCharacters = 7
    let maxCharacters = 30

    if password.count < minCharacters {
        return "Password must be more than \(minCharacters) characters"
    } else if password.count > maxCharacters {
        return "Password must be less than \(maxCharacters) characters"
    } else if !password.matches(oneUppercaseRegex) {
        return "Password must contain 1 uppercase character"
    } else if !password.matches(oneLowercaseRegex) {
        return "Password must contain 1 lowercase character"
    } else if !password.matches(oneSpecialCharRegex) {
        return "Password must contain 1 special character"
    } else if !password.matches(oneNumberRegex) {
        return "Password must contain 1 number"
    } else {
        return nil
    }
}
