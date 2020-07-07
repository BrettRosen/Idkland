//
//  String+Extensions.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import Foundation

extension String {
    public func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
