//
//  HomeViewViewModel.swift
//  SocialApp
//
//  Created by DucDo on 30/11/2023.
//

import Foundation
import FirebaseStorage
import Firebase

class HomeViewViewModel : ObservableObject {
    @Published var newPostShow = false
    @Published var listPosts : [UserWithPost] = []
    var listUserIdWithPosts : [String] = []
    init() {
        self.getUserIdsWithPosts()
    }
    
    func getUserIdsWithPosts() {
        listUserIdWithPosts = []
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, error) in
            
            if let error = error {
                print("Lỗi khi truy vấn collection users: \(error.localizedDescription)")
                return
            }
            var dispatchGroup = DispatchGroup()
            
            if let documents = snapshot?.documents {
                for document in documents {
                    let userID = document.documentID
                    dispatchGroup.enter()
                    // Kiểm tra xem collection "post" có tồn tại cho userID này hay không
                    db.collection("users").document(userID).collection("posts").getDocuments { (postSnapshot, postError) in
                        defer {
                            dispatchGroup.leave()
                        }
                        if let postError = postError {
                            print("Lỗi khi truy vấn collection post của userID \(userID): \(postError.localizedDescription)")
                            return
                        }
                        
                        if let postDocuments = postSnapshot?.documents, !postDocuments.isEmpty {
                            self.listUserIdWithPosts.append(userID)
                            print("userID \(userID) có collection post")
                        } else {
                            
                            print("userID \(userID) không có collection post")
                        }
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.getUserWithPosts()
            }
        }
    }
    
    func getUserWithPosts(){
        listPosts = []
        let db = Firestore.firestore()
        let dispatchGroup = DispatchGroup()
        let storage = Storage.storage()
        
        for userId in listUserIdWithPosts {
            dispatchGroup.enter()
            
            let userCollection = db.collection("users").document(userId)
            userCollection.getDocument { [weak self] (document, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Lỗi khi lấy dữ liệu người dùng")
                    dispatchGroup.leave()
                    return
                }
                
                if let document = document, document.exists {
                    let userData = document.data() // Thông tin của người dùng dưới dạng Dictionary
                    print("Thông tin người dùng với userID \(userId): \(userData)")
                    
                    userCollection.collection("posts").getDocuments { postSnapshot, _ in
                        defer {
                            dispatchGroup.leave()
                        }
                        
                        if let postDocuments = postSnapshot?.documents {
                            for postDocument in postDocuments {
                                let postData = postDocument.data()
                                if let imageUrlsStrings = postData["imageUrls"] as? [String] {
                                    let urls = imageUrlsStrings.compactMap {
                                        URL(string: $0)
                                        
                                    }
                                    
                                    let userWithPost = UserWithPost(userId: userData!["id"] as! String, name: userData?["name"] as! String, userImageUrls: nil, postId: postData["id"] as! String, title: postData["title"] as! String, timestamp: postData["timestamp"] as! TimeInterval, imageUrls: urls, like: postData["like"] as! Int)
                                    self.listPosts.append(userWithPost)
                                }
                            }
                        }
                        else {
                            print("Không tìm thấy người dùng với userID \(userId)")
                            dispatchGroup.leave()
                        }
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    print("Check count \(self.listPosts.count)")
                }
            }
            
        }
       
    }
}
