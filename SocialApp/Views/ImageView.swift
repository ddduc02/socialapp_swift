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
            TabView {
                ForEach(postData.post.photoData, id: \.self) { photoData in
                    Image(uiImage: UIImage(data: photoData)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
                ,alignment: .topTrailing
            )
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
