//
//  RegisterViewViewModel.swift
//  SocialApp
//
//  Created by DucDo on 28/11/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class RegisterViewViewModel : ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    func create() -> Bool {
        guard validate() else {
            return false
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self.insertRecord(userId: userId)
        }
        return true
    }
    
    func insertRecord(userId : String) {
        let user = User(id: userId, name: fullName, email: email, password: password, joined: Date())
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .setData(user.asDictionary())
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !fullName.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please enter some texts"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
                errorMessage = "Invalid email"
            return false
        }
        
        guard password.count >= 8 else {
            errorMessage = "Password must be greater 8 characters"
            return false
        }
        
        return true
        
    }
}
