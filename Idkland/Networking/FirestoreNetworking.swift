//
//  FirestoreNetworking.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import Firebase
import Foundation

let db = Firestore.firestore()

struct NetworkingError: Swift.Error, Equatable {
    init() {}
}

struct Success { }

enum FirestoreCollection: String {
    case users
    case lightPlayers
}

enum DocState<D: Decodable> {
    case exists(D)
    case doesntExist
}

class FNetworking {
    static func streamDocuments<D: Decodable>(
        collection: FirestoreCollection,
        whereField field: String,
        isEqualTo value: Any,
        callback: @escaping (Either<[D], NetworkingError>) -> ()
    ) -> ListenerRegistration {
        db.collection(collection.rawValue).whereField(field, isEqualTo: value)
            .addSnapshotListener { querySnapshot, error in
                
                guard let documents = querySnapshot?.documents, error == nil else {
                    callback(.right(NetworkingError()))
                    return
                }
                
                let data = documents.compactMap { queryDocumentSnapshot -> D? in
                    return try? queryDocumentSnapshot.data(as: D.self)
                }
                callback(.left(data))
        }
    }
    
    static func checkDocExists<D: Decodable>(
        collection: FirestoreCollection,
        documentId: String,
        callback: @escaping (Either<DocState<D>, NetworkingError>) -> ()
    ) {
        db.collection(collection.rawValue).document(documentId)
            .getDocument { querySnapshot, error in
                
                guard let document = querySnapshot, error == nil else {
                    callback(.right(NetworkingError()))
                    return
                }
                
                if document.exists {
                    do {
                        guard let data = try document.data(as: D.self) else {
                            callback(.right(NetworkingError()))
                            return
                        }
                        callback(.left(.exists(data)))
                    } catch {
                        callback(.right(NetworkingError()))
                    }
                } else {
                    callback(.left(.doesntExist))
                }
        }
    }
    
    static func getDocumentOnce<D: Decodable>(
        collection: FirestoreCollection,
        documentId: String,
        callback: @escaping (Either<D, NetworkingError>) -> ()
    ) {
        db.collection(collection.rawValue).document(documentId)
            .getDocument { querySnapshot, error in
                
                guard let document = querySnapshot, error == nil else {
                    callback(.right(NetworkingError()))
                    return
                }
                
                do {
                    guard let data = try document.data(as: D.self) else {
                        callback(.right(NetworkingError()))
                        return
                    }
                    callback(.left(data))
                } catch {
                    callback(.right(NetworkingError()))
                }
        }
    }
    
    static func setDocumentWithId<E: Encodable>(
        collection: FirestoreCollection,
        documentId: String,
        encodable: E,
        callback: @escaping (Either<Success, NetworkingError>) -> ()
    ) {
        do {
            let _ = try db.collection(collection.rawValue).document(documentId).setData(from: encodable)
            callback(.left(Success()))
        }
        catch {
            callback(.right(NetworkingError()))
        }
    }
    
    static func addDocument<E: Encodable>(
        collection: FirestoreCollection,
        encodable: E,
        callback: @escaping (Either<Success, NetworkingError>) -> ()
    ) {
        do {
            let _ = try db.collection(collection.rawValue).addDocument(from: encodable)
            callback(.left(Success()))
        }
        catch {
            callback(.right(NetworkingError()))
        }
    }

}
