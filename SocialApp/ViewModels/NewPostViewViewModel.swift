//
//  NewPostViewViewModel.swift
//  SocialApp
//
//  Created by DucDo on 01/12/2023.
//

import Foundation
import PhotosUI
import FirebaseStorage
import FirebaseAuth
import Firebase

class NewPostViewViewModel : ObservableObject {
    @Published var title = ""
    @Published var photos : [UIImage] =  []
    
    init() {
        
    }
    
    func save(save: @escaping (Bool) -> Void) {
        print("Doing save")
        print("check count photo \(photos.count)")
        var saved = true
        guard validate() else {
            saved = false
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            saved = false
            return
        }
        
        
        let postId = UUID().uuidString
        saveImage(userId: userId, postId: postId) { success in
            if success {
                self.downloadImageURL(userId: userId, postId: postId) { ok in
                    if ok {
                        saved = true
                    } else {
                        saved = false
                    }
                }
                
            } else {
                saved = false
                print("Upload failed!")
            }
        }
        save(saved)
        
    }
    
    func saveImage(userId : String, postId : String,  completion: @escaping (Bool) -> Void) {
        let storageRef = Storage.storage().reference()
        let dispatchGroup = DispatchGroup()
        var success = true
        for (index, photo) in photos.enumerated() {
            print("Doing loop")
            dispatchGroup.enter()
            guard let pngData = photo.pngData() else {
                dispatchGroup.leave()
                success = false
                return
            }
            let imageRef = storageRef.child("post/\(userId)/\(postId)\(index).png")
            
            imageRef.putData(pngData, metadata: nil) {  metadata, error in
                defer {
                    dispatchGroup.leave()
                }
                guard metadata != nil, error == nil else {
                    print("error when putData")
                    success = false
                    
                    return
                }
            }
            
        }
        dispatchGroup.notify(queue: .main) {
            completion(success)
        }
    }
    
    func downloadImageURL(userId : String, postId : String, completion: @escaping (Bool) -> Void)  {
        var photoUrls: [URL] = []
        var success = true
        let dispatchGroup = DispatchGroup()
        for (index, photo) in photos.enumerated() {
            dispatchGroup.enter()
            let storageRef = Storage.storage().reference()
            let imageRef = storageRef.child("post/\(userId)/\(postId)\(index).png")
            imageRef.downloadURL { url, error in
                defer {
                    dispatchGroup.leave()
                }
                guard let downloadURL = url else {
                    print("Error getting download URL for image \(index): \(error?.localizedDescription ?? "Unknown error")")
                    success = false
                    return
                }
                photoUrls.append(downloadURL)
                print("check URL count \(photoUrls.count)")
            }
        }
        let db = Firestore.firestore()
        dispatchGroup.notify(queue: .main) {
            let post = Post(id: postId, title: self.title, timestamp: Date().timeIntervalSince1970, imageUrls: photoUrls, like: 0)
            db.collection("users")
                .document(userId).collection("posts").document(postId).setData(post.asDictionary())
            print("Uploaded post")
            completion(success)
        }
    }
    
    func validate() -> Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
}
