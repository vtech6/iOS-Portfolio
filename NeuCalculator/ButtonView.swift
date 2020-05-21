//
//  ButtonView.swift
//  NeuCalculator
//
//  Created by Mikolaj Witkowski on 19/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

let primary = Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
let secondary = Color(#colorLiteral(red: 0.6895829439, green: 0.6854857206, blue: 0.6927336454, alpha: 1))

struct ButtonView: View {
    @State var iconName = "plus"
    var body: some View {
        ZStack {
            
            
            Circle()
                .frame(width: buttonSize[0], height: buttonSize[0])
                .foregroundColor(secondary)
                .shadow(color: Color.white.opacity(0.35), radius: 6, x: -4, y: -4)
                .shadow(color: Color.black.opacity(0.35), radius: 6, x: 4, y: 4)
            Image(systemName: iconName)
            
            .resizable()
            .aspectRatio(contentMode: .fit)
                .frame(width: buttonSize[1], height: buttonSize[1])
                
            .foregroundColor(primary)
            .shadow(color: Color.white.opacity(0.2), radius: 7, x: -4, y: -4)
            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 4, y: 3)
            
            
        }
        
    }
}

struct SymbolView: View {
    @State var symbolString = "."
    var body: some View {
        ZStack {
             Text(" ")
                       .frame(width: buttonSize[0], height: buttonSize[0])
                       .background(RadialGradient(gradient: Gradient(colors: [secondary,Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/))
                       .clipShape(Circle())
                .shadow(color: Color.white.opacity(0.35), radius: 6, x: -4, y: -4)
                .shadow(color: Color.black.opacity(0.35), radius: 6, x: 4, y: 4)
            
            Text("\(symbolString)")
                .font(.system(size: 50))
                .foregroundColor(.black)
                .frame(width: buttonSize[1], height: buttonSize[1])
                
            .foregroundColor(primary)
            .shadow(color: Color.white.opacity(0.2), radius: 7, x: -4, y: -4)
            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 4, y: 3)

        }
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolView()
    }
}
