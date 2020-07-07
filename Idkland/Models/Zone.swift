//
//  Zone.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import Foundation
import UIKit

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

struct Zone: Codable {
    var name: String
    var map: [Row]
    
    static var rows = 15
    static var columns = 9
    
    func getAsset(at row: Int, col: Int) -> String {
        map[row].cells[col].asset
    }
}

struct Row: Codable, Identifiable {
    var id = UUID()
    var cells: [Cell]
}

struct Cell: Codable, Identifiable {
    var id = UUID()
    var asset: String
}

