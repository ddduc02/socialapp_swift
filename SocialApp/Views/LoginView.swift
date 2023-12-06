//
//  LoginView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Login", subtitle: "Seamless Access to Your World Begins Here.")
                VStack {
                    Form {
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                        }
                        TextField("Email or Phone", text: $viewModel.email)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                        CButton(lable: "Log in", background: .blue, action: {
                            print("clicked login btn")
                            viewModel.login()
                        }, height: 50)
                        .padding([.vertical], 20)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 35))
                .padding(.top, -250)
                
                VStack(alignment: .leading) {
                    Text("Dont have account yet?")
                    NavigationLink(destination: RegisterView()) {
                        Text("Create a new account")
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
                
            }
        }
        .accentColor(.white)
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
