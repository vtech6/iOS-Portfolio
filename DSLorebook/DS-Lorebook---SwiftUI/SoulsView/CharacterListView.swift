//
//  CharacterListView.swift
//  SoulsView
//
//  Created by Mikolaj Witkowski on 16/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct CharacterListView: View {
    @Binding var characterInteger: Int
    @Binding var numberToggle: Int
    @Binding var characterOn: Bool
    @Binding var character1: Int
    @Binding var character2: Int
    @Binding var previousCharIndex: Int
    
    var body: some View {
        VStack (spacing: 20) {
            ForEach(0..<characters.count) { index in
                Button (action:{
                    self.previousCharIndex = self.characterInteger
                    self.characterInteger = index
                    
                    if self.characterOn {
                        self.character1 = self.characterInteger
                    }
                    else{
                        self.character2 = self.characterInteger
                    }
                    self.characterOn.toggle()
                    
                }) {
                    if index == self.characterInteger{
                    Text(characters[index].name)
                        .foregroundColor(Color(#colorLiteral(red: 0.8575424552, green: 0.7344900966, blue: 0, alpha: 1)))
                                                
                        
                    }
                    else{
                    Text(characters[index].name)
                        .foregroundColor(.white)
                        
                        
                        
                    }
                
                }
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(characterInteger: .constant(0), numberToggle: .constant(0), characterOn: .constant(false), character1: .constant(0), character2: .constant(0), previousCharIndex: .constant(1))
    }
}
