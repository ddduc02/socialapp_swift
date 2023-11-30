//
//  LoginView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Login", subtitle: "Seamless Access to Your World Begins Here.")
                VStack {
                    Form {
                        TextField("Email or Phone", text: .constant(""))
                        SecureField("Password", text: .constant(""))
                        CButton(lable: "Log in", background: .blue, action: {
                            print("clicked login btn")
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
