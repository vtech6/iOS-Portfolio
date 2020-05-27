//
//  CharacterView.swift
//  SoulsView
//
//  Created by Mikolaj Witkowski on 16/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct CharacterView: View {
    @State var previousCharIndex = 0
    @State var characterInteger = 0
    @Binding var showCharacter: Bool
    @State var numberToggle = 0
    @State var characterOn = false
    @State var character1 = 0
    @State var character2 = 2
    
    var body: some View {
        
        ZStack {
            if characterOn{CharacterDetailsView2(characterInteger: $characterInteger, showCharacter: $showCharacter, numberToggle: $numberToggle, characterOn: $characterOn, character1: $character1, character2: $character2, previousCharIndex: $previousCharIndex)
            .opacity(characterOn ? 1 : 0)
            .animation(.easeInOut)
            }else{
                CharacterDetailsView(characterInteger: $characterInteger, showCharacter: $showCharacter, numberToggle: $numberToggle, characterOn: $characterOn, character1: $character1, character2: $character2, previousCharIndex: $previousCharIndex)
                .opacity(characterOn ? 0 : 1)
                .animation(.easeInOut)
            }
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(showCharacter: .constant(true)).previewLayout(.fixed(width: 2732, height: 2048))
    }
}

struct CharacterPortraitView: View {
    
    @Binding var characterInteger: Int
    @Binding var showCharacter: Bool
    @Binding var numberToggle: Int
    var body: some View {
        HStack {
            Image(characters[characterInteger].portraitImageString)
                
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 1600)
                
                //offsets
                .offset(x: 1050, y: 100)
                .offset(x: characters[characterInteger].name==artorias.name ? -130 : 0, y: characters[characterInteger].name==artorias.name ? 50 : 0)
                .offset(x: characters[characterInteger].name==ornstein.name ? -630 : 0, y: characters[characterInteger].name==ornstein.name ? 70 : 0)
                .offset(x: characters[characterInteger].name==friede.name ? 200 : 0, y: characters[characterInteger].name==friede.name ? 200 : 0)
                .offset(x: characters[characterInteger].name==gravelordNito.name ? 40 : 0, y: characters[characterInteger].name==gravelordNito.name ? 250 : 0)
                .offset(y: characters[characterInteger].name==capra.name ? 240 : 0)
                .offset(y: characters[characterInteger].name==quelaag.name ? 370 : 0)
                
                .opacity(showCharacter ? 1 : 0)
                .offset(x: showCharacter ? 0 : -100)
                
                //scale effects
                .scaleEffect(showCharacter ? 1 : 0.9)
                .scaleEffect(characters[characterInteger].name==ornstein.name ? 1.2 : 1)
                .scaleEffect(characters[characterInteger].name==friede.name ? 0.9 : 1)
            .scaleEffect(characters[characterInteger].name==gravelordNito.name ? 0.8 : 1)
            .scaleEffect(characters[characterInteger].name==quelaag.name ? 0.9 : 1)
               
                
        }
    }
}



struct CharacterDetailsView: View {
    @Binding var characterInteger : Int
    @Binding var showCharacter: Bool
    @Binding var numberToggle : Int
    @Binding var characterOn : Bool
    @Binding var character1: Int
    @Binding var character2: Int
    @Binding var previousCharIndex: Int
    
    var body: some View {
        ZStack {
            Image(characters[character1].backgroundImageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 3840, height: 2160)
                .blur(radius: 4)
            
            HStack{
                VStack (alignment: .leading, spacing: 70) {
                    Button(action: {
                        
                        self.showCharacter.toggle()
                    }){
                        Image(systemName: "house.fill")
                            .resizable()
                            
                            .frame(width: 100, height: 100)
                    }
                    Text("Character List:")
                        .font(.custom("avenir", size: 60))
                    
                    CharacterListView(characterInteger: $characterInteger, numberToggle: $numberToggle, characterOn: $characterOn, character1: $character1, character2: $character2, previousCharIndex: $previousCharIndex)
                        .font(.custom("avenir", size: 40))
                    
                    Spacer()
                }.foregroundColor(.white)
                
                Spacer()
            }
            .frame(width: width-160, height: height-150)
            
            ZStack {
                Rectangle()
                    .frame(width: 630, height: height)
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).opacity(0.4))
                VStack (spacing: 70) {
                    Text(characters[character1].name)
                        
                        .font(.custom("avenir", size: 60))
                    
                    VStack (spacing: 50) {
                        Text(characters[character1].description[0])
                        
                        Text(characters[character1].description[1])
                        
                        if characters[character1].description.count>2{
                            Text(characters[character1].description[2])
                        }
                        
                    }
                    .font(.custom("avenir", size: 25))
                    
                    Spacer()
                }
                .foregroundColor(Color(#colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 1)))
                .frame(width: 590)
                .offset(y: 200)
            }
            .offset(x: 350)
            .opacity(showCharacter ? 1 : 0)
                
            .animation(Animation.easeInOut(duration: 0.3).delay(0.7))
            
            
            CharacterPortraitView(characterInteger: $character1, showCharacter: $showCharacter, numberToggle: $numberToggle)
                .animation(Animation.easeInOut(duration: 0.3).delay(0.5))
            
            
        }
    }
}

struct CharacterDetailsView2: View {
    @Binding var characterInteger : Int
    @Binding var showCharacter: Bool
    @Binding var numberToggle : Int
    @Binding var characterOn : Bool
    @Binding var character1: Int
    @Binding var character2: Int
    @Binding var previousCharIndex: Int
    
    var body: some View {
        ZStack {
            Image(characters[character2].backgroundImageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 3840, height: 2160)
                .blur(radius: 4)
            
            HStack{
                VStack (alignment: .leading, spacing: 70) {
                    Button(action: {
                        
                        self.showCharacter.toggle()
                    }){
                        Image(systemName: "house.fill")
                            .resizable()
                            
                            .frame(width: 100, height: 100)
                    }
                    Text("Character List:")
                        .font(.custom("avenir", size: 60))
                    
                    CharacterListView(characterInteger: $characterInteger, numberToggle: $numberToggle, characterOn: $characterOn, character1: $character1, character2: $character2, previousCharIndex: $previousCharIndex)
                        .font(.custom("avenir", size: 40))
                    
                    Spacer()
                }.foregroundColor(.white)
                
                Spacer()
            }
            .frame(width: width-160, height: height-150)
            
            ZStack {
                Rectangle()
                    .frame(width: 630, height: height)
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).opacity(0.4))
                VStack (spacing: 70) {
                    Text(characters[character2].name)
                        
                        .font(.custom("avenir", size: 60))
                    
                    VStack (spacing: 50) {
                        Text(characters[character2].description[0])
                        
                        Text(characters[character2].description[1])
                        
                        if characters[character2].description.count>2{
                            Text(characters[character2].description[2])
                        }
                        
                    }
                    .font(.custom("avenir", size: 25))
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .frame(width: 590)
                .offset(y: 200)
            }
            .offset(x: 350)
            .opacity(showCharacter ? 1 : 0)
                
            .animation(Animation.easeInOut(duration: 0.3).delay(1))
            
            
            CharacterPortraitView(characterInteger: $character2, showCharacter: $showCharacter, numberToggle: $numberToggle)
                .animation(Animation.easeInOut(duration: 0.3).delay(0.5))
            
            
            
        }
    }
}
