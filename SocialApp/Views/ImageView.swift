//
//  ImageView.swift
//  SocialApp
//
//  Created by DucDo on 06/12/2023.
//

import SwiftUI

struct ImageView: View {
    @EnvironmentObject var postData : PostViewViewModel
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            TabView{
                ForEach(postData.post.imageUrls, id: \.self) { url in
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Text("Failed to load image")
                        case .empty:
                            Text("Loading...")
                        @unknown default:
                            Text("Error!")
                        }
                    }
                      
                }
               
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .overlay(
                Button(action: {
                    withAnimation(.default) {
                        postData.showImageView.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                        .clipShape(Circle())
                })
                .padding()
                ,alignment: .topTrailing
            )
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
