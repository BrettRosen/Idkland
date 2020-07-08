//
//  BasicBackgroundView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/7/20.
//

import SwiftUI

struct BasicBackgroundView: View {
    var body: some View {
        Colors.background.value.edgesIgnoringSafeArea(.all)
    }
}

struct BasicBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BasicBackgroundView()
    }
}
