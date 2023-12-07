//
//  PostViewViewModel.swift
//  SocialApp
//
//  Created by DucDo on 03/12/2023.
//

import Foundation
import FirebaseStorage
class PostViewViewModel : ObservableObject {
    @Published var post : UserWithPost
    @Published var showImageView = false
    init(post : UserWithPost) {
        self.post = post
        self.getImage()
    }
    
    func getImage() {
        var photoData : [Data] = []
        let storageRef = Storage.storage().reference()
        let dispatchGroup = DispatchGroup()
        print("check post id \(post.id)")
        let imageRef = storageRef.child("post/\(post.postId)/")
        dispatchGroup.enter()
        imageRef.listAll { (image, error) in
            defer {
                dispatchGroup.leave()
                print("leave 1")
            }
            print("Start looping 1")
            if let error = error {
                // Handle the error if there's any
                print("Error fetching images: \(error.localizedDescription)")
            } else if let items = image?.items {
                print("check items \(items)")
                for item in items {
                    dispatchGroup.enter()
                    print("Start looping")
                    // 'item' là một tệp trong thư mục 'post/postId'
                    item.getData(maxSize: 10 * 1024 * 1024) { data, error in
                        defer {
                            dispatchGroup.leave()
                            print("leave")
                        }
                        if let error = error {
                            // Xử lý lỗi khi lấy dữ liệu
                            print("Lỗi khi lấy dữ liệu tệp: \(error.localizedDescription)")
                        } else if let data = data {
                            // Sử dụng dữ liệu ở đây (data là dữ liệu của tệp)
                            photoData.append(data)
                            // Tiếp tục xử lý với ảnh hoặc dữ liệu nhận được
                        }
                        
                    }
                    
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            print("done all task")
            self.post.photoData = photoData
        }
    }
}
