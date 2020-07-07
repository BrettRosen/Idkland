//
//  AppClient.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import Foundation

struct AppClient {
    var getSignedInUser: () -> Effect<User, NetworkingError>
}

extension AppClient {
    static var live = AppClient(getSignedInUser: {
        Effect.future { callback in
            FNetworking.getSignedInUser { either in
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
