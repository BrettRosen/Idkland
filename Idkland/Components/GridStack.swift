//
//  GridStack.swift
//  Idkland
//
//  Created by Brett Rosen on 7/7/20.
//

import SwiftUI

let screen = UIScreen.main.bounds

let cellWidth = screen.width / 9
let cellHeight = screen.height / 19.5

struct GridStack<Content: View>: View {
    
    let rows: Int
    let columns: Int
    let contentFrame: CGSize
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                            .frame(width: contentFrame.width, height: contentFrame.height)
                    }
                }
            }
        }
    }
    
    init(
        rows: Int = Zone.rows,
        columns: Int = Zone.columns,
        contentFrame: CGSize = CGSize(width: cellWidth, height: cellHeight),
        @ViewBuilder content: @escaping (Int, Int) -> Content
    ) {
        self.rows = rows
        self.columns = columns
        self.contentFrame = contentFrame
        self.content = content
    }
}

struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        GridStack { row, col in
            Text("R\(row), R\(col)")
        }
    }
}
