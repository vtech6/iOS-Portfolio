//
//  ContentView.swift
//  SoulsView
//
//  Created by Mikolaj Witkowski on 16/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let uiScale: CGFloat = 20
    @State var showCharacter = false
    var body: some View {
        ZStack {
            VStack {
                
                VStack (spacing: 100) {
                    Text("The World of")
                        .font(.custom("OptimusPrinceps", size: 5 * uiScale))
                        .offset(y: 60)
                        
                    Text("DARK SOULS")
                        .font(.custom("OptimusPrinceps", size: 20 * uiScale))
                    Button(action:{self.showCharacter.toggle()}){
                    Text("CONTINUE")
                    .font(.custom("OptimusPrinceps", size: 3 * uiScale))
                        .offset(y:30)
                        
                    }
                        
                        
                }.font(.custom("arial", size: 1))
                .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .offset(y:-50)
                    
                
            }
            .frame(width: width, height: height)
            .background(Color.black)
                .edgesIgnoringSafeArea(.all)
            .opacity(self.showCharacter ? 0 : 1)
            .animation(.easeInOut(duration: 0.3))
        
        CharacterView(showCharacter: $showCharacter)
        .opacity(self.showCharacter ? 1 : 0)
        }.animation(.easeInOut(duration: 0.5))
    
        .scaleEffect(0.51)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(showCharacter: false).previewLayout(.fixed(width: width, height: height))
    }
}

let width: CGFloat = 2732
let height: CGFloat = 2048
