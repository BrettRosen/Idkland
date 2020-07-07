//
//  GameNetworking.swift
//  Idkland
//
//  Created by Brett Rosen on 7/6/20.
//

import Firebase
import Foundation

extension FNetworking {
    
    private static var lightPlayersListener: ListenerRegistration?
    
    static func streamLightPlayers(
        in zoneId: String,
        callback: @escaping (Either<[LightPlayer], NetworkingError>) -> ()
    ) {
        lightPlayersListener?.remove()
        lightPlayersListener = FNetworking.streamDocuments(collection: .lightPlayers, whereField: "zoneId", isEqualTo: zoneId, callback: callback)
    }
    
    
    /// This function will check if a `LightPlayer` already exists for the user and return it if it does.
    /// If it does not, it will create that `LightPlayer`, add it to the database, and return it
    static func getOrAddLightPlayer(
        for user: User,
        callback: @escaping (Either<LightPlayer, NetworkingError>) -> ()
    ) {
        guard let userId = user.id else {
            callback(.right(NetworkingError()))
            return
        }
        
        let lightPlayer = LightPlayer(
            id: user.id,
            username: user.username,
            asset: "😁",
            zoneId: "1",
            zonePosition: .center
        )
        
        FNetworking.checkLightPlayerExists(userId: userId) { either in
            switch either {
            case let .left(state):
                switch state {
                case .doesntExist:
                    FNetworking.addDocumentWithId(collection: .lightPlayers, documentId: userId, encodable: lightPlayer, callback: { either in
                        switch either {
                        case .left:
                            callback(.left(lightPlayer))
                        case let .right(error):
                            callback(.right(error))
                        }
                    })
                case let .exists(lightPlayer):
                    callback(.left(lightPlayer))
                }
            case let .right(error):
                callback(.right(error))
            }
        }
    }
    
    static func addLightPlayer(lightPlayer: LightPlayer, callback: @escaping (Either<Success, NetworkingError>) -> ()) {
        guard let id = lightPlayer.id else {
            callback(.right(NetworkingError()))
            return
        }
        return FNetworking.addDocumentWithId(collection: .lightPlayers, documentId: id, encodable: lightPlayer, callback: callback)
    }
    
    static func checkLightPlayerExists(userId: String, callback: @escaping (Either<DocState<LightPlayer>, NetworkingError>) -> ()) {
        
        FNetworking.checkDocExists(collection: .lightPlayers, documentId: userId, callback: callback)
    }

}
