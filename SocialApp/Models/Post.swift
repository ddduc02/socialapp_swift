//
//  Post.swift
//  SocialApp
//
//  Created by DucDo on 30/11/2023.
//

import Foundation

struct Post {
    let id: String
    let title : String
    let timestamp : TimeInterval
    let imageUrl : URL?
    let descreption : String
    let like : Int
}
