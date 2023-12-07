//
//  Post.swift
//  SocialApp
//
//  Created by DucDo on 30/11/2023.
//

import Foundation

struct Post : Encodable{
    let id: String
    let title : String
    let timestamp : TimeInterval
    let photoData : [Data]?
    let like : Int
}
