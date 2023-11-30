//
//  User.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import Foundation

struct User : Codable {
    let id: String
    let name: String
    let email: String
    let password: String
    let joined: Date
}
