//
//  BasicLoadingView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/6/20.
//

import SwiftUI

struct BasicLoadingView: View {
    var body: some View {
        ProgressView {
            Text("Loading")
                .foregroundColor(Colors.primary.value)
                .font(.body)
                .bold()
        }
    }
}

struct BasicLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        BasicLoadingView()
    }
}
