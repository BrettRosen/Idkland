//
//  ShakeDetectingView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import SwiftUI
import UIKit

struct ShakeDetectingView: UIViewControllerRepresentable {
    
    var callback: () -> Void
    
    func makeUIViewController(context: Context) -> ShakableViewController {
        ShakableViewController(callback: callback)
    }
    
    func updateUIViewController(_ uiViewController: ShakableViewController, context: Context) {}
}


class ShakableViewController: UIViewController {
    
    var callback: () -> Void = {}
    
    init(callback: @escaping () -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.callback = callback
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        callback()
    }
}
