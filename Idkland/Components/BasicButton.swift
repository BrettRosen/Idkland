//
//  BasicButton.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import SwiftUI

struct BasicButton: View {
    
    let text: String
    var isLoading = false
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            ZStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .opacity(isLoading ? 1 : 0)
                Text(text)
                    .font(.callout)
                    .foregroundColor(.white)
                    .bold()
                    .opacity(isLoading ? 0 : 1)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: isLoading ? 24 : 12).foregroundColor(.blue))
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 10)
        }
        .disabled(isLoading)
        .animation(.easeIn)
    }
}

struct BasicButton_Previews: PreviewProvider {
    static var previews: some View {
        BasicButton(text: "Login", action: { })
    }
}
