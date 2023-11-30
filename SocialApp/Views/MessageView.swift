//
//  MessageView.swift
//  SocialApp
//
//  Created by DucDo on 27/11/2023.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Message page")
            }
            .navigationTitle("Message")
        }
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
