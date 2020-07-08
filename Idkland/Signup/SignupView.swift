//
//  SignupView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import SwiftUI

struct SignupView: View {
    
    let store: Store<SignupState, SignupAction>
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack(alignment: .top) {
                
                BasicBackgroundView()
                
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                    VStack {
                        
                        HStack {
                            Text("🎠 Signup")
                                .font(.title)
                                .bold()
                                .foregroundColor(Colors.primary.value)
                            Spacer()
                        }
                        
                        ValidatedTextField(
                            title: "Username",
                            subtitle: "This will be displayed in game",
                            isOptional: false,
                            placeHolder: "Choose a username",
                            value: $username,
                            error: viewStore.core.usernameError
                        )
                        ValidatedTextField(
                            title: "Email",
                            isOptional: false,
                            placeHolder: "Enter your email",
                            value: $email,
                            error: viewStore.core.emailError
                        )
                        ValidatedTextField(
                            title: "Password",
                            isOptional: false,
                            isSecure: true,
                            placeHolder: "Choose a password",
                            value: $password,
                            error: viewStore.core.passwordError
                        )
                        
                        BasicButton(text: "Signup", isLoading: viewStore.core.isLoading) {
                            viewStore.send(.signupTapped(username: self.username, email: self.email, password: self.password))
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(store: Store(initialState: SignupState(), reducer: signupReducer, environment: SignupEnvironment(client: .live)))
    }
}
