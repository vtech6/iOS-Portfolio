//
//  CardView.swift
//  DecodeChinese
//
//  Created by Mikolaj Witkowski on 03/09/2020.
//
//Before we jump into the code below, I wanted to underline, that if any data is missing it's very easy to work around that with optionals in swift.

import SwiftUI
import AVFoundation

struct CardView: View {
    
    //To play our audio files we need AVAudioPlayer from AVFoundation
    //I instantiate empty arrays for easier data management, so that the data loads into view only if it exists, otherwise the views don't appear, but without crashing the rest.
    //imageToShow helps us pass data to our sheet view.
    
    @State var audioPlayer: AVAudioPlayer!
    @State var wordData: [Word] = []
    @State var wordNumber = 0
    @State var selectedCharacter = 0
    @State var characterID = 0
    @State var component: [Component] = []
    @State var showImageDetail = false
    @State var imageToShow = ""
    
    var body: some View {
        VStack {
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                //Checking if data loads properly
                if wordData.count>0{
                    //The issue with characters being cropped could also be solved by introducing a scale or reducing font size as the character count increases (for example: decrease font size for every 2 characters)
                    VStack {
                        HStack{
                            ForEach(wordData[wordNumber].characters, id: \.self.id){character in
                                VStack{
                                    //Here we can see that hanzi represents pinyin, while pinyin represents hanzi. Could be easily solved by entering data properly :D
                                    Text(character.hanzi).font(.system(size: 55))
                                    Text(character.pinyin)}
                                    .foregroundColor(fetchColor(num: character.pinyin_tone))
                            }
                        }.frame(minWidth: screen.width).padding()
                        VStack{
                            Text("Definition").font(.caption).foregroundColor(.gray).padding(.bottom, 5)
                            Text(wordData[wordNumber].meaning).font(.subheadline)
                        }
                        .padding(.vertical)
                        VStack {
                            Text("Sentence").font(.caption).foregroundColor(.gray)
                            Text(wordData[wordNumber].sentence.pinyin).padding(5)
                            Text(wordData[wordNumber].sentence.hanzi).font(.subheadline).padding(5).fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            Text(wordData[wordNumber].sentence.meaning).padding(5).font(.subheadline)
                        }
                        .multilineTextAlignment(.center)
                        .padding()
                    }.frame(width: screen.width-80)
                    HStack{
                        Button(action: {
                            let sound = Bundle.main.path(forResource: wordData[wordNumber].audio, ofType: nil)
                            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                            self.audioPlayer.play()
                            generateHapticFeedback()
                        })
                        {
                            HStack {
                                Image(systemName: "play.circle")
                                    .resizable().frame(width: 44, height: 44)
                                Text("Listen").font(.title)
                            }
                        }
                        .padding()
                        .foregroundColor(Color("buttonColor"))
                        Button(action: {if !(wordNumber >= wordData.count-1){
                            wordNumber+=1
                        }else{
                            wordNumber=0
                        }
                        characterID = wordData[wordNumber].characters[0].id
                        component = wordData[wordNumber].characters[0].component
                        generateHapticFeedback()
                        }
                        ){
                            Image(systemName: "arrow.uturn.down.circle")
                                .resizable().frame(width: 44, height: 44)
                            Text("Next Card")}
                        .padding()
                        .font(.title)
                        .foregroundColor(Color("buttonColor"))
                    }
                    .frame(width: screen.width)
                    .padding(.vertical)
                    .background(Color.gray.opacity(0.1))
                    VStack{
                        HStack{
                            ForEach(wordData[wordNumber].characters, id: \.self.id){ character in
                                Button(action:{characterID = character.id
                                    component = character.component
                                    generateHapticFeedback()
                                }){
                                    HStack {
                                        Text(character.hanzi).font(.system(size: 30)).foregroundColor(character.id == characterID ? fetchColor(num: character.pinyin_tone) : Color.gray.opacity(0.4)
                                        )
                                        Text(character.pinyin).foregroundColor(character.id == characterID ? fetchColor(num: character.pinyin_tone) : Color.gray.opacity(0.4)
                                        )
                                    }
                                }
                            }
                        }.padding(.vertical)
                        VStack{
                            ForEach(wordData[wordNumber].characters, id: \.self.id){ character in
                                if character.id == characterID{
                                    HStack(alignment: .top){
                                        VStack(alignment: .leading){
                                            Text("Radical").font(.subheadline)
                                            HStack{
                                                Text(character.radical.hanzi).font(.system(size: 20)).padding()
                                                VStack(alignment: .leading){
                                                    Text(character.radical.pinyin).foregroundColor(fetchColor(num: character.radical.pinyin_tone))
                                                    Text(character.radical.meaning)
                                                }
                                            }
                                        }
                                        VStack (alignment: .leading){
                                            if character.radical.variation.count>0{Text("Variation").font(.subheadline)
                                                HStack {
                                                    ForEach(character.radical.variation, id: \.self){ variation in
                                                        Text(variation).padding()
                                                    }
                                                }
                                            }}.padding(.horizontal)
                                        Spacer()
                                    }
                                    HStack{
                                        VStack (alignment: .leading){
                                            if component.count>0{Text("Component").font(.subheadline)
                                                VStack (alignment: .leading) {
                                                    ForEach(component, id: \.self.hanzi){ comp in
                                                        VStack(alignment: .leading){
                                                            HStack{
                                                                Text(comp.hanzi).font(.system(size: 20)).padding()
                                                                VStack(alignment: .leading){
                                                                    Text(comp.pinyin).foregroundColor(fetchColor(num: comp.pinyin_tone))
                                                                    Text(comp.meaning)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            VStack(alignment: .leading){
                                                Text("Charater Decomposition").font(.subheadline).padding(.vertical)
                                                Text(character.etymology_note.character_decomposition).font(.body)
                                            }.multilineTextAlignment(.leading)
                                            VStack(alignment: .leading){
                                                Text("Decomposition Notes").font(.subheadline).padding(.vertical)
                                                Text(character.etymology_note.decomposition_notes).font(.body)
                                            }.multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                    }
                                    HStack (spacing: 20){
                                        ForEach(character.etymology_note.image, id: \.self.file_name){ filename in
                                            
                                            Image(filename.file_name).resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 200).background(Color("imageBackground")).onTapGesture{
                                                showImageDetail = true
                                                imageToShow = filename.file_name
                                                generateHapticFeedback()
                                            }.clipShape(RoundedRectangle(cornerRadius: 10))
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }.frame(width: screen.width-90)
                    }
                }
            }.frame(width:screen.width).onAppear{
                loadJson(fromURLString: urlString) { (result) in
                    switch result {
                    case .success(let data):
                        wordData = (parse(jsonData: data))
                        characterID = wordData[wordNumber].characters[selectedCharacter].id
                        component = wordData[wordNumber].characters[selectedCharacter].component
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }.sheet(isPresented: $showImageDetail){
            ImageDetailView(image: imageToShow, showImageDetail: $showImageDetail)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}


