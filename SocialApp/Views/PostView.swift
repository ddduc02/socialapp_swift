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
        self._viewModel =  StateObject(wrappedValue: PostViewViewModel(post: post) )
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
                        ForEach(0..<viewModel.post.photoData.count, id: \.self) { i in
                            Button {
                                viewModel.showImageView.toggle()
                            } label: {
                                ZStack {
                                    if i <= 3 {
                                        Image(uiImage: UIImage(data: viewModel.post.photoData[i])!)
                                            .resizable()
                                            .frame(width: 150, height: 150)
                                            .aspectRatio(contentMode: .fill)
                                    }
                                    if viewModel.post.photoData.count > 4 && i == 3 {
                                        RoundedRectangle (cornerRadius: 12)
                                            .fill(Color.black.opacity (0.3))
                                        let remainingImages =
                                        viewModel.post.photoData.count - 4
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
        PostView(post: UserWithPost(userId: "", name: "String", userImageUrls: URL(string: ""), postId: "", title: "", timestamp: Date().timeIntervalSince1970, photoData: [], like: 0))
    }
}
