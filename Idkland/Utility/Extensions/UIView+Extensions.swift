//
//  UIView+Extensions.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import Foundation
import UIKit

extension UIView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIApplication.shared.windows
            .first { $0.isKeyWindow }?
            .endEditing(true)
    }
}
