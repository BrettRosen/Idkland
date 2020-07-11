//
//  ZoneObject.swift
//  Idkland
//
//  Created by Brett Rosen on 7/10/20.
//

import Foundation

struct ZoneObject: Codable, Equatable {

    var id: UUID
    var name: String
    var asset: String
    var position: ZonePosition
    var components = [Component]()
    
}

extension ZoneObject {
    static var mock = ZoneObject(
        id: UUID(),
        name: "Rabbit",
        asset: "🐇",
        position: .center,
        components: [.tooltip(text: "A friendly rabbit")]
    )
}
