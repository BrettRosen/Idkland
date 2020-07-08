//
//  GameClient.swift
//  Idkland
//
//  Created by Brett Rosen on 7/6/20.
//

import Combine
import ComposableArchitecture
import Foundation

struct GameClient {
    /// Input - `zoneID: String`
    var streamLightPlayers: (String) -> Effect<[LightPlayer], NetworkingError>
    var getOrAddLightPlayer: (User) -> Effect<LightPlayer, NetworkingError>
    var updateLightPlayer: (LightPlayer) -> Effect<Success, NetworkingError>
}

extension GameClient {
    static var live = GameClient(streamLightPlayers: { zoneId in
        Effect.run { subscriber in
            FNetworking.streamLightPlayers(in: zoneId) { either in
                switch either {
                case .left(let lightPlayers):
                    subscriber.send(.init(lightPlayers))
                case .right(let error):
                    subscriber.send(completion: .failure(error))
                }
            }
            return AnyCancellable { }
        }
    }, getOrAddLightPlayer: { user in
        Effect.future { callback in
            FNetworking.getOrAddLightPlayer(for: user) { either in
                switch either {
                case let .left(lightPlayer):
                    callback(.success(lightPlayer))
                case let .right(error):
                    callback(.failure(error))
                }
            }
        }
    }, updateLightPlayer: { lightPlayer in
        Effect.future { callback in
            FNetworking.setLightPlayer(lightPlayer) { either in
                switch either {
                case .left:
                    callback(.success(Success()))
                case let .right(error):
                    callback(.failure(error))
                }
            }
        }
    })
}

struct DebounceID: Hashable {}
