//
//  HomeView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct HomeView: View {
    public let userId : String
    @StateObject var viewModel : HomeViewViewModel
    init(userId : String) {
        self.userId = userId
        self._viewModel = StateObject(wrappedValue: HomeViewViewModel())
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    HStack(alignment: .top) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.vertical, 12)
                        
                        Text("What's on your mind? Click here!")
                            .padding(.all)
                            .foregroundColor(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .frame(width: .infinity)
                            .onTapGesture {
                                viewModel.newPostShow = true
                            }
                        
                        Spacer()
                    }
                    Text("Home page")
                    ForEach(viewModel.listPosts){ post in
                        PostView(post: post)
                            .padding(.bottom, 10)
                        
                    }
                    Spacer()
                }
                .navigationTitle("Home")
                .sheet(isPresented: $viewModel.newPostShow) {
                    NewPostView(postImages: [],
                                newPostShow: $viewModel.newPostShow)
                }
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userId: "abc")
    }
}
