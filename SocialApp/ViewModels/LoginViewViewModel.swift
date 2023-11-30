//
//  LoginViewViewModel.swift
//  SocialApp
//
//  Created by DucDo on 28/11/2023.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    init() {
        
    }
    
    func login() -> Bool {
        guard validate() else {
            return false
        }
        
        do {
            try Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            print("Login failed")
            return false
        }
        return true
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please enter some texts"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid message"
            return false
        }
        return true
    }
}
