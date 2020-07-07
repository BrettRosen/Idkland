//
//  Zone.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import Foundation
import UIKit

struct ZonePosition: Codable, Equatable {
    var row: Int
    var col: Int
    
    static var center = ZonePosition(row: 7, col: 4)
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

