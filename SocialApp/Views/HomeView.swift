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
    @StateObject var viewModel = HomeViewViewModel()
    init(userId : String) {
        self.userId = userId
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")

        usersCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                guard let documents = querySnapshot?.documents else { return }

                let userIds = documents.compactMap { $0.documentID }
                // userIds chứa tất cả các userId từ collection "users"
                print(userIds)
            }
        }
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
                .padding(.all)
                Text("Home page")
                Spacer()
            }
            .navigationTitle("Home")
            .sheet(isPresented: $viewModel.newPostShow) {
                NewPostView(postImages: [], 
                    newPostShow: $viewModel.newPostShow)
            }
        }
        .onAppear()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userId: "abc")
    }
}
