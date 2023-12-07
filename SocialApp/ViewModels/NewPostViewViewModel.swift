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
    @Published var photos : [UIImage?] =  []
    // để lưu lên firebase
    var photoData : [Data] = []
    
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
                self.insertToFirebase(userId: userId, postId: postId)
            } else {
                saved = false
                print("Upload failed!")
            }
        }
        save(saved)
        
    }
    
    func saveImage(userId: String, postId: String, completion: @escaping (Bool) -> Void) {
        let storageRef = Storage.storage().reference()
        let dispatchGroup = DispatchGroup()
        var success = true
        var imageDataDict = [Int: Data]() // Dictionary to store image data with index
        
        for (index, photo) in photos.enumerated() {
            print("Doing loop")
            dispatchGroup.enter()
            guard let jpegData = photo!.jpegData(compressionQuality: 0.6) else {
                dispatchGroup.leave()
                success = false
                return
            }
            photoData.append(jpegData)
            imageDataDict[index] = jpegData // Store image data with index
        }
        
        for (index, imageData) in imageDataDict {
            dispatchGroup.enter()
            let imagePath = "post/\(postId)/\(index).jpg"
            
            let imageRef = storageRef.child(imagePath)
            
            imageRef.putData(imageData, metadata: nil) { _, error in
                
                if let error = error {
                    print("Error when putData: \(error.localizedDescription)")
                    success = false
                }
                dispatchGroup.leave()
                print("Leaving dispatchGroup \(index)")
            }
        }
        print("ok1")
            completion(success)
    }
    
    func insertToFirebase(userId : String, postId : String) {
        let db = Firestore.firestore()
        let post = Post(id: postId, title: self.title, timestamp: Date().timeIntervalSince1970, photoData: nil, like: 0)
        db.collection("users")
            .document(userId).collection("posts").document(postId).setData(post.asDictionary()) { error in
                if let error = error {
                    print("Error uploading post: \(error.localizedDescription)")
                } else {
                    print("Uploaded post")
                }
            }
    }
    
    //    func downloadImage(userId : String, postId : String, completion: @escaping (Bool) -> Void)  {
    //        let storageRef = Storage.storage().reference()
    //        var success = true
    //        let dispatchGroup = DispatchGroup()
    //        for (index, photo) in photos.enumerated() {
    //            dispatchGroup.enter()
    //            let imageRef = storageRef.child("post/\(userId)/\(postId)\(index).png")
    //            imageRef.getData(maxSize: 50 * 1024 * 1024) { data, error in
    //                defer {
    //                    dispatchGroup.leave()
    //                }
    //                if let error = error {
    //                    print("Error getting image data: \(error.localizedDescription)")
    //                    success = false
    //                } else {
    //                    self.photoData.append(data)
    //                    success = true
    //                }
    //            }
    //        }
    //        let db = Firestore.firestore()
    //        dispatchGroup.notify(queue: .main) {
    //            let post = Post(id: postId, title: self.title, timestamp: Date().timeIntervalSince1970, imageUrls: self.photoData, like: 0)
    //            let postRef = db.collection("users")
    //                .document(userId).collection("posts").document(postId).setData(post.asDictionary()) { error in
    //                    if let error = error {
    //                            print("Error uploading post: \(error.localizedDescription)")
    //                        } else {
    //                            print("Uploaded post")
    //                        }
    //            }
    //
    //            completion(success)
    //        }
    //    }
    
    func validate() -> Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
}
