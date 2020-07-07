//
//  LoginNetworking.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import Firebase
import Foundation

extension FNetworking {
    
    static func getSignedInUser(callback: @escaping (Either<User, NetworkingError>) -> ()) {
        if let uid = Auth.auth().currentUser?.uid {
            FNetworking.getUser(documentId: uid, callback: callback)
        } else {
            callback(.right(NetworkingError()))
        }
    }
    
    static func login(
        email: String,
        password: String,
        callback: @escaping (Either<User, NetworkingError>) -> ()
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let result = authResult, error == nil else {
                callback(.right(NetworkingError()))
                return
            }
            FNetworking.getUser(documentId: result.user.uid, callback: callback)
        }
    }
    
    private static func getUser(documentId: String, callback: @escaping (Either<User, NetworkingError>) -> ()) {
        FNetworking.getDocumentOnce(collection: .users, documentId: documentId, callback: callback)
    }
}
