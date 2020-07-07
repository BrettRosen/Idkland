//
//  SignupClient.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import Foundation

struct SignupClient {
    var signup: (String, String, String) -> Effect<User, NetworkingError>
}

extension SignupClient {
    static var live = SignupClient(signup: { username, email, password in
        Effect.future { callback in
            FNetworking.signup(username: username, email: email, password: password) { either in
                switch either {
                case let .left(user):
                    callback(.success(user))
                case let .right(error):
                    callback(.failure(error))
                }
            }
        }
    })
}

