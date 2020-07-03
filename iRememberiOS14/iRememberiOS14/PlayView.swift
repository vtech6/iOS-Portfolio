//
//  PlayView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 26/06/2020.
//

import SwiftUI

func generateRandomInteger(playIndex: Int, set: [Flashcard]) -> Int{
    var intArray: [Int] = []
    for i in 0..<set.count {
            if i != playIndex{
                intArray.append(i)
            }
        }
        return intArray.randomElement() ?? 0
}

func generateRandomAnswers(playIndex: Int, set: [Flashcard])->[String]{
    let randomInt = generateRandomInteger(playIndex: playIndex, set: set)
    let answers = [set[playIndex].wrappedAnswer, set[randomInt].wrappedAnswer]
    var randomOrderAnswers: [String] = []
    
    randomOrderAnswers.append(answers.randomElement() ?? "NoAnswer")
    answers.forEach{
        if randomOrderAnswers.contains($0)==false{
        randomOrderAnswers.append($0)
        }
    }
    return randomOrderAnswers
}

struct PlayView: View {
    @Binding var showPlay: Bool
    @State var set: FlashcardSet
    @State var playIndex = 0
    @State var showAnswer = false
    @State var answers: [String]
    @State var correctCounter = 0
    @State var showSummary = false
    
    func summaryText() -> String {
        switch correctCounter{
        case set.flashcardArray.count:
            return "Flawless!"
        case (set.flashcardArray.count/2)..<set.flashcardArray.count:
            return "Not Bad!"
        default:
            return "Try Again?"
        }
    }
    

    var body: some View {
        ZStack {
            
            VStack{
                Text(set.flashcardArray[playIndex].wrappedQuestion)
                    .font(device.contains("iPad") ? .largeTitle : .title)
                Spacer()
                HStack{
                    Button(action:{
                        //Check if correct
                        if answers[0] == set.flashcardArray[playIndex].wrappedAnswer{
                            correctCounter+=1
                        }
                        //Generate Random Answers
                        if playIndex != set.flashcardArray.count-1{
                            playIndex+=1}else{
                                showSummary.toggle()
                                playIndex=0
                            }
                        self.answers = generateRandomAnswers(playIndex: playIndex, set: set.flashcardArray)
                    }){
                        Text(answers[0]).font(device.contains("iPad") ? .system(size: 20) : .body)
                            .frame(width: UIDevice.current.orientation.isLandscape ? screen.height/2 : screen.width/2)
                            .multilineTextAlignment(.center)
                        
                    }
                    Button(action:{
                        if answers[1] == set.flashcardArray[playIndex].wrappedAnswer{
                            correctCounter+=1
                        }
                        if playIndex != set.flashcardArray.count-1{
                            playIndex+=1}else{
                                showSummary.toggle()
                                playIndex=0
                            }
                        self.answers = generateRandomAnswers(playIndex: playIndex, set: set.flashcardArray)
                    }){
                        Text(answers[1]).font(device.contains("iPad") ? .system(size: 20) : .body).frame(width:UIDevice.current.orientation.isLandscape ? screen.height/2 : screen.width/2)
                            
                            .multilineTextAlignment(.center)
                        
                    }
                }.animation(nil)
            }.onAppear {
                self.answers = generateRandomAnswers(playIndex: playIndex, set: set.flashcardArray)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIDevice.current.orientation.isLandscape ? screen.width/2 :screen.height/2)
            .blur(radius: showSummary ? 5 : 0)
            .animation(.easeInOut(duration: 0.3))
            .zIndex(showSummary ? 0.0 : 1.0)
            
            VStack {
                Text("Correct Answers: \(String(correctCounter))/\(set.flashcardArray.count)")
                
                Text("\(summaryText())")
                
            }
            .zIndex(showSummary ? 1.0 : 0.0)
            .offset(y: showSummary ? 0 : UIDevice.current.orientation.isLandscape ? screen.height : screen.width).animation(.spring())
            .frame(width: UIDevice.current.orientation.isLandscape ? screen.height : screen.width, height:UIDevice.current.orientation.isLandscape ? screen.width : screen.height)
            .background(Color.white.opacity(0.01))
            .onTapGesture{if showSummary{
                showSummary.toggle()
                self.correctCounter=0
            }}
        }
        
        
    }
}


