//
//  LearnView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 02/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//
//  This view displays questions and answers that are embedded in a flashcard.
//
//
import SwiftUI

struct LearnView: View {
    @Binding var showLearn: Bool
    @Binding var setIndex: Int //setIndex refers to an index of a flashcard set
    @Binding var cardInteger: Int
    @Binding var showQuestion: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Text("")
            }
            .frame(width: 400, height:  900)
            .background(RadialGradient(gradient: Gradient(colors: [darkPink, Color(#colorLiteral(red: 0.9298675656, green: 0.4987058043, blue: 0.6786029935, alpha: 0.7080211901))]), center: .topLeading, startRadius: 100, endRadius: 1240))
            .edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    FlashCardView(showQuestion: true, cardInteger: $cardInteger, tileColor: Color.white, setIndex: $setIndex, showLearn: $showLearn)
                        .offset(y:-65)
                }
                Spacer()
            }
            .frame(width: screen.width-25, height: screen.height-50)
            .background(LinearGradient(gradient: Gradient(colors: [darkBlue, lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(1))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .blendMode(.hardLight)
            .padding(.top, 20)
        }
        
    }
}

struct FlashCardView: View {
    @State var showQuestion: Bool
    @Binding var cardInteger: Int
    @State var tileColor: Color
    @Binding var setIndex: Int
    @Binding var showLearn: Bool
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Text(allSets.sets[self.setIndex].title)
                        .font(.system(size: 30))
                        .padding()
                    Spacer()
                    Button (action: {if self.showQuestion == false {
                        self.showQuestion.toggle()
                        }
                        self.showLearn.toggle()
                        self.cardInteger=0
                    }) {
                        Image(systemName: "multiply")
                            .resizable()
                            .foregroundColor(veryLightPurple)
                            .clipped()
                            .frame(width:30, height: 30)
                            .padding()
                    }
                }
                ZStack {
                    ProgressRingView(end: CGFloat(self.cardInteger+1)/CGFloat(allSets.sets[self.setIndex].qna.endIndex), scale: 0.7)
                    Text("\(cardInteger+1)/\(allSets.sets[setIndex].qna.endIndex)")
                        .animation(nil)
                }
                .offset(y:10)
                .scaleEffect(1.3)
            }
            .frame(height: 200)
            
            
            Spacer()
            ZStack{
                
                VStack{
                    Text("\(allSets.sets[self.setIndex].qna[self.cardInteger][0])")
                        .animation(nil)
                }
                .offset(x: showQuestion ? 0 : -500)
                .opacity(showQuestion ? 1 : 0)
                
                VStack{
                    Text("\(allSets.sets[self.setIndex].qna[self.cardInteger][1])")
                        .animation(nil)
                }
                .offset(x: showQuestion ? 500 : 0)
                .opacity(showQuestion ? 0 : 1)
            }
            .multilineTextAlignment(.center)
            .animation(.easeInOut(duration: 0.2))
            .padding()

            Spacer()
            
            HStack (spacing: 20) {
                Button(action: {
                    if self.showQuestion == false {
                        self.showQuestion.toggle()
                    }
                    if self.cardInteger == 0 {
                        self.cardInteger = allSets.sets[self.setIndex].qna.endIndex-1
                    }
                    else {
                        self.cardInteger -= 1
                    }
                }) {
                    TileView(text: "Previous", scale: 0.6, color: tileColor, iconName: "arrow.left")
                }
                Button(action: {self.showQuestion.toggle()}) {
                    TileView(text: "Reverse", scale: 0.6, color: tileColor, iconName: "arrow.2.squarepath")
                }
                Button(action: {
                    if self.showQuestion == false {
                        self.showQuestion.toggle()
                    }
                    if self.cardInteger < allSets.sets[self.setIndex].qna.endIndex-1 {
                        self.cardInteger+=1
                    }
                    else {
                        self.cardInteger = 0
                    }
                }) {
                    TileView(text: "Next", scale: 0.6, color: tileColor, iconName: "arrow.right")
                }
            }
            .shadow(color: Color.white.opacity(0.1), radius: 10)
            .blendMode(.softLight)
            .offset(y: -35)
        }
        .offset(y: 50)
    }
}


struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView(showLearn: .constant(false), setIndex: .constant(0), cardInteger: .constant(0), showQuestion: .constant(true))
    }
}

