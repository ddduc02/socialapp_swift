//
//  ProfileView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Profile page")
            }
            .navigationTitle("Profile")
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
