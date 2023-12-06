//
//  NewPostView.swift
//  SocialApp
//
//  Created by DucDo on 30/11/2023.
//

import SwiftUI
import PhotosUI
struct NewPostView: View {
    @StateObject var viewModel = NewPostViewViewModel()
    @State var postImages : [UIImage] = []
    @State var photosPickerItem : [PhotosPickerItem] = []
    @Binding var newPostShow : Bool
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Create a new post")
                        .bold()
                        .font(.system(size: 30))
                    Spacer()
                    Button {
                        viewModel.save { success in
                            if success {
                                newPostShow = false
                            }
                        }
                    } label: {
                        Text("Post")
                        
                    }
                }
                TextEditor(text: $viewModel.title)
                    .textFieldStyle(PlainTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .frame(height: 200)
                
                if(viewModel.photos.count > 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<viewModel.photos.count, id: \.self) { i in
                                Image(uiImage: viewModel.photos[i])
                                    .resizable()
                                    .frame(width: 350, height: 350)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                    }
                    PhotosPicker("Choose your images", selection: $photosPickerItem, selectionBehavior: .ordered, matching: .images)
                } else {
                  
                        PhotosPicker(selection: $photosPickerItem, selectionBehavior: .ordered, matching: .images) {
                            HStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 30, height: 25)
                                Text("Choose your images")
                            }
                        }
                      
                    Spacer()
                }
                
            }
        }
        .padding()
        .onChange(of: photosPickerItem) { _ in
            viewModel.photos.removeAll()
            Task {
                for item in photosPickerItem {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            viewModel.photos.append(image)
                        }
                    }
                }
            }
            
        }
    }
    
}


struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(postImages: [],
                    newPostShow: Binding (
                        get : {
                            return true
                        }, set : { _ in}
                    ))
    }
}
