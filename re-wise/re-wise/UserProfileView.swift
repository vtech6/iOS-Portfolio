//
//  UserProfileView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 05/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    @State var userName: String
    var body: some View {
        
        ZStack (alignment: .bottom){
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.black)
                .frame(width: screen.width-50, height: 300)
            .blendMode(.softLight)

            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.white).opacity(0.7)
                    .frame(width: 250, height: 90)
                .blendMode(.hardLight)

                HStack {
                    
                    Image("IMG_0714")
                        
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                    
                    Text("\(userName), 22")
                        .font(.title)
                    
                }
                .frame(width: 200, height: 50)
                .padding()
            }
        .padding()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userName: "Nick")
    }
}
