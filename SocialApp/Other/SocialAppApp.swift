//
//  SocialAppApp.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI
import FirebaseCore
@main
struct SocialAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
