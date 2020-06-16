//
//  PlayTruthView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 13/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

func generateRandomNumber (setIndex: Int, cardIndex: Int) -> Int {
    let number = setIndex
    let cardI = cardIndex
    var numbersArray: [Int] = []
    for i in 0..<allSets.sets[number].qna.count {
        if i != cardI{
            numbersArray.append(i)
        }
    }
    return numbersArray.randomElement() ?? 0
}

struct PlayTruthView: View {
    @Binding var showPlay: Bool
    @Binding var cardInteger: Int
    @Binding var setIndex: Int
    @Binding var randomNumber: Int
    @Binding var questions: [String]
    @Binding var answer1: String
    @Binding var answer2: String
    @Binding var correctCounter: Int
    @Binding var showResults: Bool
    @Binding var total: Int
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button (action: {
                        self.showPlay.toggle()
                        // Generating random numbers
                        self.randomNumber = generateRandomNumber(setIndex: self.setIndex, cardIndex: self.cardInteger)
                        
                        print(self.randomNumber)
                        
                        let questions = [allSets.sets[self.setIndex].qna[self.cardInteger][1], allSets.sets[self.setIndex].qna[self.randomNumber][1]]
                        
                        self.answer1 = questions.randomElement() ?? "none"
                        if self.answer1 != questions[0] {
                            self.answer2 = questions[0]
                        } else {
                            self.answer2 = questions[1]
                        }
                        self.questions = questions
                        // End of section
                    }) {
                        Image(systemName: "multiply")
                            .resizable()
                            .foregroundColor(Color.black)
                            .clipped()
                            .frame(width:30, height: 30)
                            .padding()
                            .offset(y:10)
                    }
                }
                
                ProgressRingView(end: CGFloat(self.cardInteger+1)/CGFloat(allSets.sets[self.setIndex].qna.endIndex), scale: 0.7)
                
                Spacer()
                
                Text("\(self.cardInteger+1). \(allSets.sets[self.setIndex].qna[self.cardInteger][0])")
                    .animation(nil)
                    .multilineTextAlignment(.center)
                
                Spacer()
                HStack{
                    VStack{
                        Button(action: {
                            if self.questions[0] == self.answer1 && self.cardInteger < allSets.sets[self.setIndex].qna.endIndex-1 {
                                self.cardInteger+=1
                                self.correctCounter+=1
                                
                                // Generating random numbers
                                self.randomNumber = generateRandomNumber(setIndex: self.setIndex, cardIndex: self.cardInteger)
                                
                                let questions = [allSets.sets[self.setIndex].qna[self.cardInteger][1], allSets.sets[self.setIndex].qna[self.randomNumber][1]]
                                
                                self.answer1 = questions.randomElement() ?? "none"
                                
                                if self.answer1 != questions[0] {
                                    self.answer2 = questions[0]
                                } else {
                                    self.answer2 = questions[1]
                                }
                                self.questions = questions
                                // End of section
                            }
                            else{
                                if self.cardInteger < allSets.sets[self.setIndex].qna.endIndex-1 {
                                    self.cardInteger+=1
                                    // Generating random numbers
                                    self.randomNumber = generateRandomNumber(setIndex: self.setIndex, cardIndex: self.cardInteger)
                                    
                                    //Generating one correct and one randomly incorrect answer
                                    let questions = [allSets.sets[self.setIndex].qna[self.cardInteger][1], allSets.sets[self.setIndex].qna[self.randomNumber][1]]
                                    //Setting answer 1 to equal a random element from the array above
                                    self.answer1 = questions.randomElement() ?? "none"
                                    if self.answer1 != questions[0] {
                                        self.answer2 = questions[0]
                                    } else {
                                        self.answer2 = questions[1]
                                    }
                                    //Setting self.questions to equal the array above, so that we could use it with the
                                    // if statement
                                    self.questions = questions
                                    // End of section
                                } else{
                                    if self.questions[0] == self.answer1{
                                        self.correctCounter+=1
                                        self.showResults.toggle()
                                    }
                                    else{self.showResults.toggle()}
                                }
                            }
                        }){
                            Text("\(self.answer1)")
                        }
                    }
                    Spacer()
                    VStack{
                        Button(action: {
                            if self.questions[0] == self.answer2 && self.cardInteger < allSets.sets[self.setIndex].qna.endIndex-1 {
                                self.cardInteger+=1
                                self.correctCounter+=1
                                
                                // Generating random numbers
                                self.randomNumber = generateRandomNumber(setIndex: self.setIndex, cardIndex: self.cardInteger)
                                
                                //Generating one correct and one randomly incorrect answer
                                let questions = [allSets.sets[self.setIndex].qna[self.cardInteger][1], allSets.sets[self.setIndex].qna[self.randomNumber][1]]
                                //Setting answer 1 to equal a random element from the array above
                                self.answer1 = questions.randomElement() ?? "none"
                                if self.answer1 != questions[0] {
                                    self.answer2 = questions[0]
                                } else {
                                    self.answer2 = questions[1]
                                }
                                //Setting self.questions to equal the array above, so that we could use it with the
                                // if statement
                                self.questions = questions
                                // End of section
                            }
                            else {
                                if self.cardInteger < allSets.sets[self.setIndex].qna.endIndex-1 {
                                    self.cardInteger+=1
                                    
                                    // Generating random numbers
                                    self.randomNumber = generateRandomNumber(setIndex: self.setIndex, cardIndex: self.cardInteger)
                                    
                                    //Generating one correct and one randomly incorrect answer
                                    let questions = [allSets.sets[self.setIndex].qna[self.cardInteger][1], allSets.sets[self.setIndex].qna[self.randomNumber][1]]
                                    //Setting answer 1 to equal a random element from the array above
                                    self.answer1 = questions.randomElement() ?? "none"
                                    if self.answer1 != questions[0] {
                                        self.answer2 = questions[0]
                                    } else {
                                        self.answer2 = questions[1]
                                    }
                                    //Setting self.questions to equal the array above, so that we could use it with the
                                    // if statement
                                    self.questions = questions
                                    // End of section
                                } else{
                                    if self.questions[0] == self.answer2{
                                        self.correctCounter+=1
                                        self.showResults.toggle()
                                    }
                                    else{self.showResults.toggle()}
                                }
                            }
                        }){
                            Text("\(self.answer2)")
                                .animation(nil)
                        }
                    }
                }
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                Text("Current Score: \(self.correctCounter)/\(self.total)")
                    .padding()
                Spacer()
            }
            .frame(width: screen.width-25, height: screen.height-50)
            .background(LinearGradient(gradient: Gradient(colors: [darkBlue, lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(1))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .blendMode(.hardLight)
            .padding(.top, 20)
            
            PlayResultsView(cardInteger: $cardInteger, setIndex: $setIndex, correctCounter: $correctCounter, showResults: $showResults, total: $total, showPlay: $showPlay)
                .offset(y: 100)
                .offset(y: showResults ? 0 : 500)
        }
        
        
    }
}

struct PlayTruthView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTruthView(showPlay: .constant(true), cardInteger: .constant(0), setIndex: .constant(0), randomNumber: .constant(0), questions: .constant([""]), answer1: .constant(""), answer2: .constant(""), correctCounter: .constant(0), showResults: .constant(false), total: .constant(0))
    }
}
