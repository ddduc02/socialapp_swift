//
//  MainViewViewModel.swift
//  SocialApp
//
//  Created by DucDo on 28/11/2023.
//

import Foundation
import FirebaseAuth

class MainViewViewModel : ObservableObject {
    @Published var currentUserId = ""
    private var handler : AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener({ _, user in
            DispatchQueue.main.async {
                self.currentUserId = user?.uid ?? ""
            }
        })
    }
    
    func isSignIn() -> Bool {
        return Auth.auth().currentUser?.uid != nil
    }
}
