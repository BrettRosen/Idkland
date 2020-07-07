//
//  SettingsClient.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import Firebase
import Foundation

struct SettingsClient {
    var logout: () -> Effect<Success, NetworkingError>
}

extension SettingsClient {
    static var live = SettingsClient(logout: {
        Effect.future { callback in
            do {
                try Auth.auth().signOut()
                callback(.success(Success()))
            } catch let signOutError as NSError {
                callback(.failure(NetworkingError()))
            }
        }
    })
}
