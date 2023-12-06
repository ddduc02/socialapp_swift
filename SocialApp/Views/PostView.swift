//
//  PostView.swift
//  SocialApp
//
//  Created by DucDo on 03/12/2023.
//

import SwiftUI

struct PostView: View {
    @StateObject var viewModel : PostViewViewModel
    
    init(post : UserWithPost) {
        self._viewModel = StateObject(wrappedValue: PostViewViewModel(post: post) )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "person.circle.fill")
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text(viewModel.post.name)
                        .bold()
                        .font(.system(size: 20))
                    Text("\(viewModel.post.title)")
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(0..<viewModel.post.imageUrls.count, id: \.self) { i in
                            Button {
                                viewModel.showImageView.toggle()
                            } label: {
                                ZStack {
                                    if i <= 3 {
                                        AsyncImage(url: viewModel.post.imageUrls[i]) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .frame(width: 150, height: 150)
                                                    .aspectRatio(contentMode: .fill)
                                            case .failure:
                                                Text("Failed to load image")
                                            case .empty:
                                                Text("Loading...")
                                            @unknown default:
                                                Text("Error!")
                                            }
                                        }
                                    }
                                    if viewModel.post.imageUrls.count > 4 && i == 3 {
                                        RoundedRectangle (cornerRadius: 12)
                                            .fill(Color.black.opacity (0.3))
                                        let remainingImages =
                                        viewModel.post.imageUrls.count - 4
                                        Text ("+ \(remainingImages)")
                                            .font (.title)
                                            .fontWeight (.heavy)
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                            }

                            
                        }
                    }
                }
                
            }
            
        }
        .overlay {
            ZStack {
                if viewModel.showImageView {
                    ImageView()
                        .environmentObject(viewModel)
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: UserWithPost(userId: "", name: "String", userImageUrls: URL(string: ""), postId: "", title: "", timestamp: Date().timeIntervalSince1970, imageUrls: [ URL(string :"https://firebasestorage.googleapis.com:443/v0/b/socialapp-cd51c.appspot.com/o/post%2FRx7MIHfVe5ZqLfB8scCRE189MXL2%2F3D9FDAA9-C514-4472-BD79-821BD7119F280.png?alt=media&token=f089b63f-614b-4e38-886b-51ec7c7be829")
                                                                                                                                                                             ,URL(string: "https://firebasestorage.googleapis.com:443/v0/b/socialapp-cd51c.appspot.com/o/post%2FRx7MIHfVe5ZqLfB8scCRE189MXL2%2F3D9FDAA9-C514-4472-BD79-821BD7119F281.png?alt=media&token=34e6171a-7032-45c2-a745-de391f94c3b6"
                                                                                                                                                                                 )
                                                                                                                                                                           ], like: 0))
    }
}
