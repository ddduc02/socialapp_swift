//
//  SocialAppApp.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

@main
struct SocialAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
