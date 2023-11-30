//
//  HomeView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

struct HomeView: View {
    public let userId : String
    
    init(userId : String) {
        self.userId = userId
    }
    var body: some View {
        NavigationView {
            VStack{
                HStack(alignment: .top) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                    
                    NavigationLink(destination: NewPostView()) {
                        Text("What's on your mind? Click here!")
                            .padding(.all)
                            .foregroundColor(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .frame(width: .infinity)
                    }
                    Spacer()
                }
                .padding(.all)
                Text("Home page")
                Spacer()
            }
            .navigationTitle("Home")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userId: "abc")
    }
}
