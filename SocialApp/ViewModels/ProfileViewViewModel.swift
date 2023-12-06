//
//  ProfileViewViewModel.swift
//  SocialApp
//
//  Created by DucDo on 06/12/2023.
//

import Foundation
import FirebaseAuth


class ProfileViewViewModel : ObservableObject {
    
    init() {
        
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
}
