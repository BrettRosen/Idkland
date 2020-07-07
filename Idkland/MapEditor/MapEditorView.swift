//
//  MapEditorView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import SwiftUI

struct MapEditorView: View {
    
    @State var didShake = false
    @Binding var position: CGPoint
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(zone.indices) { rowIndex in
                HStack(spacing: 0) {
                    ForEach(zone[rowIndex].cells.indices) { cellIndex in
                        
                        GeometryReader { reader in
                            Button(action: {
                                position = CGPoint(
                                    x: reader.frame(in: .global).midX,
                                    y: reader.frame(in: .global).midY
                                )
                            }) {
                                Rectangle()
                                .foregroundColor(Colors.primary.value.opacity(0.6))
                                .overlay(
                                    Text("r\(rowIndex),c\(cellIndex)")
//                                    Text("x\(Int(reader.frame(in: .global).midX)), y\(Int(reader.frame(in: .global).midY))")
                                        .font(.caption)
                                )
                            }
                        }
                        .frame(width: cellWidth, height: cellHeight)
                    }
                }
            }
        }
        .drawingGroup()
    }
}

struct MapEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MapEditorView(position: .constant(.zero))
    }
}
