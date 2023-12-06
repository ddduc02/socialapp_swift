//
//  PostViewViewModel.swift
//  SocialApp
//
//  Created by DucDo on 03/12/2023.
//

import Foundation

class PostViewViewModel : ObservableObject {
    @Published var post : UserWithPost
    @Published var showImageView = false
    
    init(post : UserWithPost) {
        self.post = post
    }
}
