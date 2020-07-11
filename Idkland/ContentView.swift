//
//  ContentView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/4/20.
//

import SwiftUI

// Aspect Ratio 19.5 : 9
    
let zone = Array.init(
    repeating: Row(tiles: Array.init(repeating: Tile(hexColor: "32CD32", zoneObject: .mock), count: Zone.columns)),
    count: Zone.rows
)

func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
    return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
}

func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
    return sqrt(CGPointDistanceSquared(from: from, to: to))
}

struct ContentView: View {
    
    @State var location: CGPoint = CGPoint(x: screen.midX, y: screen.midY)
    @State var text: String = ""

    var body: some View {
        ZStack {
            
            Color.yellow.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 1) {
                ForEach(zone) { row in
                    HStack(spacing: 1) {
                        ForEach(row.tiles) { cell in
                            Rectangle()
                                .frame(width: cellWidth, height: cellHeight)
                                .foregroundColor(cell.color)
                                .overlay(
                                    Text(cell.zoneObject?.asset ?? "")
                                        .font(.largeTitle)
                                )
                        }
                    }
                }
            }
            .drawingGroup()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}

struct Background: UIViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)

    func makeUIView(context: UIViewRepresentableContext<Background>) -> UIView {
        let v = UIView(frame: .zero)
        let gesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.tapped)
        )
        v.addGestureRecognizer(gesture)
        return v
    }

    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)
        init(tappedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
        }
        @objc func tapped(gesture: UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point)
        }
    }

    func makeCoordinator() -> Background.Coordinator {
        return Coordinator(tappedCallback: self.tappedCallback)
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Background>) {
    }

}
