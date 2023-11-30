//
//  LoginView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            
            HeaderView(title: "Sign Up", subtitle: "Join the Community, Connect with Ease")
            VStack {
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("Your fullname", text: $viewModel.fullName)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    TextField("Email or Phone", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    CButton(lable: "Create", background: .blue, action: {
                        if viewModel.create() {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }, height: 50)
                    .padding([.vertical], 20)
                    
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 35))
            .padding(.top, -250)
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
