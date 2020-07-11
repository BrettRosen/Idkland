//
//  Component.swift
//  Idkland
//
//  Created by Brett Rosen on 7/10/20.
//

enum Component: Equatable {
    case tooltip(text: String)
    case zoneTransfer(zoneId: String, zoneName: String)
}

extension Component: Codable {
    enum CodingKeys: String, CodingKey {
        case component
        case tooltipText
        case zoneId
        case zoneName
    }
    
    private enum ComponentKey: String, Codable {
        case tooltip
        case zoneTransfer
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case let .tooltip(text):
            try container.encode(ComponentKey.tooltip, forKey: .component)
            try container.encode(text, forKey: .tooltipText)
        case let .zoneTransfer(zoneId, zoneName):
            try container.encode(ComponentKey.zoneTransfer, forKey: .component)
            try container.encode(zoneId, forKey: .zoneId)
            try container.encode(zoneName, forKey: .zoneName)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)        
        let component = try container.decode(ComponentKey.self, forKey: .component)
        
        switch component {
        case .tooltip:
            let text = try container.decode(String.self, forKey: .tooltipText)
            self = .tooltip(text: text)
        case .zoneTransfer:
            let zoneId = try container.decode(String.self, forKey: .zoneId)
            let zoneName = try container.decode(String.self, forKey: .zoneName)
            self = .zoneTransfer(zoneId: zoneId, zoneName: zoneName)
        }
    }
}
