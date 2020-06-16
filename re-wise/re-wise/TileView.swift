//
//  CardView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 29/04/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct TileView: View {
    var text: String
    var scale: CGFloat = 0.9
    var color: Color
    var iconName: String = "gear"
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 3)
            
            RoundedRectangle(cornerRadius: 20)
            .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundColor(color).opacity(0.4)
            .shadow(color: color.opacity(0.1), radius: 5 * scale, x: -1, y: -1)
                
            VStack {
                Spacer()
                Image(systemName: iconName)
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:40, height: 40)
                    
                Text(text)
                    .font(.subheadline)
                .bold()
                    .shadow(color: Color.white.opacity(0.1), radius: 1)
                .offset(y: -5)
            }
                .foregroundColor(Color.black)
            .frame(width:CGFloat(150 * scale), height: CGFloat(150 * scale))
            .blendMode(.softLight)
            
            
        }.frame(width:CGFloat(150 * scale), height: CGFloat(150 * scale))
    
        
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(text: "learn", scale: 0.5, color: Color.red, iconName: "gear")
    }
}
