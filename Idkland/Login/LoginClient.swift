//
//  LoginClient.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import Foundation

struct LoginClient {
    var login: (String, String) -> Effect<User, NetworkingError>
}

extension LoginClient {
    static var live = LoginClient(login: { email, password in
        Effect.future { callback in
            FNetworking.login(email: email, password: password) { either in
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
