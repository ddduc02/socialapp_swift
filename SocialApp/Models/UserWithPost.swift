//
//  UserWithPost.swift
//  SocialApp
//
//  Created by DucDo on 03/12/2023.
//

import Foundation

struct UserWithPost : Identifiable {
    let id: UUID = UUID()
    let userId: String
    let name: String
    let userImageUrls : URL?
    let postId: String
    let title : String
    let timestamp : TimeInterval
    var photoData : [Data]
    let like : Int
}
