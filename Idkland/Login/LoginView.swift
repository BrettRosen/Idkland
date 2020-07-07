//
//  LoginView.swift
//  Idkland
//
//  Created by Brett Rosen on 7/5/20.
//

import ComposableArchitecture
import SwiftUI

struct LoginView: View {
    
    let store: Store<LoginState, LoginAction>
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack(alignment: .top) {
                Colors.background.value.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 32) {
                    Text("🏖 Idkland")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(Colors.primary.value)
                    
                    ValidatedTextField(
                        title: "Email",
                        isOptional: false,
                        placeHolder: "Enter your email",
                        keyboardType: .emailAddress,
                        value: $email,
                        error: viewStore.core.emailError
                    )
                    
                    ValidatedTextField(
                        title: "Password",
                        isOptional: false,
                        isSecure: true,
                        placeHolder: "Enter your password",
                        value: $password,
                        error: viewStore.core.passwordError
                    )
                    
                    BasicButton(text: "Login", isLoading: viewStore.core.isLoading) {
                        viewStore.send(.loginTapped(email: self.email, password: self.password))
                    }
                    
                    Button(action: {
                        viewStore.send(.toggleSignupModal(on: true))
                    }) {
                        Text("No account? Signup")
                            .font(.callout)
                            .bold()
                            .foregroundColor(Colors.primary.value.opacity(0.6))
                            
                    }
                    .sheet(isPresented: viewStore.binding(
                        get: \.showSignupModal,
                        send: LoginAction.toggleSignupModal(on:)
                    )) {
                        SignupView(store: self.store.scope(
                            state: \.signupState,
                            action: LoginAction.signupAction
                        ))
                    }
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(initialState: LoginState(), reducer: loginReducer, environment: LoginEnvironment(client: .live)))
    }
}
