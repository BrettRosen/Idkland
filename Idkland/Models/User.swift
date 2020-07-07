//
//  User.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import FirebaseFirestoreSwift
import Foundation

struct User: Codable, Equatable {
    
    @DocumentID var id: String? = nil
    var role: Role
    var username: String
    
    enum Role: String, Codable {
        case normal
        case admin
    }
    
    func isAdmin() -> Bool { role == .admin }
}
