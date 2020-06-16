//
//  PlaySetsChoiceView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 15/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct PlaySetsView: View {
    @Binding var setIndex: Int
    @Binding var showPlaySets: Bool
    @Binding var showPlay: Bool
    @Binding var randomNumber: Int
    @Binding var cardInteger: Int
    @Binding var questions: [String]
    @Binding var answer1: String
    @Binding var answer2: String
    @Binding var total: Int
    
    var body: some View {
        return ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    VStack (spacing: 5){
                        
                        ForEach(1..<allSets.sets.count+1) { itemIndex in
                            
                            ZStack {
                                CardSetFaceView()
                                Button (action: {
                                    self.cardInteger = 0
                                    self.setIndex = itemIndex-1
                                    self.showPlay.toggle()
                                    // Generating random numbers
                                    self.randomNumber = generateRandomNumber(setIndex: self.setIndex, cardIndex: self.cardInteger)
                                    
                                    self.total = allSets.sets[itemIndex-1].qna.count
                                    
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
                                    VStack {
                                        Text(allSets.sets[itemIndex-1].title)
                                            .font(.title)
                                            .bold()
                                        
                                        Spacer()
                                        Text(allSets.sets[itemIndex-1].description)
                                        
                                    }
                                    .foregroundColor(Color.black)
                                    .shadow(color: Color.white.opacity(0.1), radius: 1, x: 0, y: 0)
                                    .frame(width: 250, height: 100)
                                    .multilineTextAlignment(.center)
                                    .padding(30)
                                }
                            }
                        }
                    }
                }
                .frame(height: 900)
                .offset(y: 53)
                .padding(.top, 50)
                
                
                Spacer()
            }
            .frame(width: screen.width-25, height: screen.height-50)
            .background(LinearGradient(gradient: Gradient(colors: [darkBlue, lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(1))
                
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .blendMode(.hardLight)
            .padding(.top, 20)
            
            VStack {
                HStack {
                    Text("Your Sets")
                        .font(.title)
                        .padding(30)
                    
                    Spacer()
                    Button (action: {self.showPlaySets.toggle()}) {
                        Image(systemName: "house.fill")
                            .resizable()
                            .foregroundColor(veryLightPurple)
                            .clipped()
                            .frame(width:30, height: 30)
                            .padding()
                        
                    }
                }
                Spacer()
            }
            .frame(width: screen.width-25, height: screen.height-50)
            
            
        }
        
    }
}

struct PlaySetsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaySetsView(setIndex: .constant(0), showPlaySets: .constant(false), showPlay: .constant(false), randomNumber: .constant(0), cardInteger: .constant(0), questions: .constant(["", ""]), answer1: .constant(""), answer2: .constant(""), total: .constant(0))
    }
}
