//
//  HomeView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    var body: some View {
        if (viewModel.isSignIn()) {
            TabView {
                HomeView(userId: viewModel.currentUserId)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                MessageView()
                    .tabItem {
                        Label("Messages", systemImage: "message.fill")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle.fill")
                    }
            }
        } else {
            LoginView()
        }


    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
