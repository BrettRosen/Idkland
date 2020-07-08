//
//  LightPlayer.swift
//  Idkland
//
//  Created by Brett Rosen on 7/6/20.
//

import FirebaseFirestoreSwift
import Foundation

/// Represents a player that a user sees in a zone, only needs important display
/// information and the player's position in the zone
struct LightPlayer: Codable, Equatable, Identifiable {
    
    @DocumentID var id: String? = nil
    var username: String
    var asset: String
    var zoneId: String
    var zonePosition : ZonePosition
    
}

extension LightPlayer {
    static var mock = LightPlayer(id: "1", username: "Brejuro", asset: "😁", zoneId: "1", zonePosition: .center)
}
