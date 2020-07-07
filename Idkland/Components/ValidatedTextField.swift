//
//  ValidatedTextField.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import SwiftUI

struct ValidatedTextField: View {
    
    var title: String = ""
    var subtitle: String = ""
    var isOptional: Bool = false
    var isSecure: Bool = false
    var placeHolder: String = ""
    var keyboardType: UIKeyboardType = .default
   
    @Binding var value: String
    var error: String
            
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment: .lastTextBaseline) {
                if !isOptional {
                    Circle()
                        .foregroundColor(Colors.alert.value)
                        .frame(width: 6, height: 6)
                }
                
                if title != "" {
                    Text(title)
                    .bold()
                    .font(.body)
                    .foregroundColor(Colors.primary.value)
                    .animation(nil)
                }
                
                if isOptional {
                    Text("(optional)")
                    .font(.body)
                    .foregroundColor(Colors.primary.value)
                    .opacity(0.65)
                    .animation(nil)
                }
            }
            
            if !subtitle.isEmpty {
                Text(subtitle)
                .bold()
                .font(.footnote)
                .foregroundColor(Colors.primary.value.opacity(0.6))
                .animation(nil)
            }
            
            if self.isSecure {
                SecureField(placeHolder, text: $value)
                    .font(.body)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .foregroundColor(Colors.primary.value)
                    .keyboardType(keyboardType)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Colors.accent.value)
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 10)
                    )
            } else {
                TextField(placeHolder, text: $value)
                    .font(.body)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .foregroundColor(Colors.primary.value)
                    .keyboardType(keyboardType)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Colors.accent.value)
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 10)
                    )
            }

            HStack {
                Image(systemName: "exclamationmark.circle")
                    .font(.footnote)
                    .foregroundColor(Colors.alert.value)
                    .opacity(error == "" ? 0 : 1)
                Text(error)
                    .font(.footnote)
                    .foregroundColor(Colors.alert.value)
            }
            .padding(.top, 4)
            .animation(.easeIn)
        }
    }
}


struct ValidatedTextField_Previews: PreviewProvider {
    static var previews: some View {
        ValidatedTextField(title: "Test", isOptional: false, placeHolder: "Enter stuff", keyboardType: .default, value: .constant(""), error: "Test error")
    }
}

