//
//  HeaderView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

struct HeaderView: View {
    let title : String
    let subtitle : String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
            VStack (alignment: .leading){
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold()
                Text(subtitle)
                    .font(.system(size: 22))
                    .foregroundColor(Color.white)
                
            }
            .padding([.horizontal], 9)
            .padding(.top, 30)
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 450)
        .offset(y: -150)
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "ABc", subtitle: "ABc")
    }
}
