//
//  SignupNetworking.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import Firebase
import Foundation

extension FNetworking {
        
    static func signup(
        username: String,
        email: String,
        password: String,
        callback: @escaping (Either<User, NetworkingError>) -> ()
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let result = authResult, error == nil else {
                callback(.right(NetworkingError()))
                return
            }
            
            let user = User(id: result.user.uid, role: .normal, username: username)
            FNetworking.addUser(user, callback: callback)
        }
    }
    
    private static func addUser(_ user: User, callback: @escaping (Either<User, NetworkingError>) -> ()) {
        do {
            let _ = try db.collection(FirestoreCollection.users.rawValue).document(user.id!).setData(from: user)
            callback(.left(user))
        }
        catch {
            callback(.right(NetworkingError()))
        }
    }
}
