//
//  Zone.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import Foundation
import UIKit
import SwiftUI

let screen = UIScreen.main.bounds

let cellWidth = screen.width / 9
let cellHeight = screen.height / 19.5

struct ZonePosition: Codable, Equatable {
    var row: Int
    var col: Int
    
    static var center = ZonePosition(row: 7, col: 4)
    
    func getGlobalPosition() -> CGPoint {
        let centerPosition = CGPoint(x: screen.midX, y: screen.midY)
        
        let centerRow = ZonePosition.center.row
        let centerCol = ZonePosition.center.col
        
        let rowDif = CGFloat(row - centerRow)
        let colDif = CGFloat(col - centerCol)
        
        return CGPoint(
            x: centerPosition.x + colDif * cellWidth,
            y: centerPosition.y + rowDif * cellHeight
        )
    }
}

struct Zone: Codable, Equatable {
    var name: String
    var map: [Row]
    
    static var rows = 15
    static var columns = 9
    
    func getTileColor(at row: Int, col: Int) -> Color {
        map[row].tiles[col].color
    }
    
    func getZoneObject(at row: Int, col: Int) -> ZoneObject? {
        map[row].tiles[col].zoneObject
    }
}

struct Row: Codable, Identifiable, Equatable {
    var id = UUID()
    var tiles: [Tile]
}

struct Tile: Codable, Identifiable, Equatable {
    var id = UUID()
    var hexColor: String
    var zoneObject: ZoneObject?
    
    var color: Color {
        Color(hex: self.hexColor)
    }
}
