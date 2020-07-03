//
//  MenuView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 29/04/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

var lightPink = Color(#colorLiteral(red: 0.9713370204, green: 0.5116025209, blue: 0.6997048259, alpha: 1))
var darkPink = Color(#colorLiteral(red: 0.8689311147, green: 0.4576897621, blue: 0.6258657575, alpha: 1))
var lightBlue = Color(#colorLiteral(red: 0.4673722386, green: 0.8374532461, blue: 0.9800700545, alpha: 1))
var darkBlue = Color(#colorLiteral(red: 0.2493346632, green: 0.7544942498, blue: 0.9736552835, alpha: 1))

var veryLightPurple = Color(#colorLiteral(red: 0.6323700547, green: 0.7233965397, blue: 0.9559810758, alpha: 1))

struct MenuView: View {
    @State var showSettings = false
    @State var showProfile = false
    @State var showLearn = false
    @State var showLearnSets = false
    @State var setIndex = 0
    @State var cardInteger = 0
    @State var showQuestion = true
    @State var showBuild = false
    @State var showPlaySets = false
    @State var showPlay = false
    
    @State var randomNumber = 0
    @State var questions = [""]
    @State var answer1 = ""
    @State var answer2 = ""
    @State var correctCounter = 0
    @State var showResults = false
    @State var total = 0
    

    let profileName = "Nick"
    let scale: CGFloat = 0.6
    let color = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var body: some View {
        ZStack {
            VStack {
                Text("")
            }
            .frame(width: 400, height:  900)
            .background(RadialGradient(gradient: Gradient(colors: [darkPink, Color(#colorLiteral(red: 0.9298675656, green: 0.4987058043, blue: 0.6786029935, alpha: 0.7080211901))]), center: .topLeading, startRadius: 100, endRadius: 1240))
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {self.showSettings.toggle()}) {
                        IconView(iconName: "gear")
                    }
                    Spacer()
                    Button (action: {self.showProfile.toggle()}) {
                        IconView(iconName: "person.circle")
                    }
                }
                .padding(30)
                .foregroundColor(veryLightPurple)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1), radius:1)
                HStack {
                    Text("Welcome Back, \(profileName)!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(7)
                        .allowsTightening(true)
                }
                .frame(height:100)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1), radius:3)
                .blendMode(.softLight)
                .frame(width: 300)
                .offset(y: 50)
                Spacer()
                HStack {
                    HStack (spacing: 20){
                        Button (action: {self.showLearnSets.toggle()}) {
                            TileView(text: "Learn", scale: scale, color: color, iconName: "book.fill")
                        }
                        Button (action: {self.showBuild.toggle()}) {
                            TileView(text: "Create", scale: scale, color: color, iconName: "hammer.fill")
                        }
                        Button(action: {self.showPlaySets.toggle()}) {
                            TileView(text: "Play", scale: scale, color: color, iconName: "gamecontroller.fill")
                        }
                    }
                    .frame(height: 200)
                    .opacity(0.9)
                    .shadow(color: Color.white.opacity(0.1), radius: 10)
                    .padding()
                    .blendMode(.softLight)
                }
                .offset(y:-30)
            }
            .frame(width: screen.width-25, height: screen.height-50)
            .background(LinearGradient(gradient: Gradient(colors: [darkBlue, lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(1))
            .blendMode(.hardLight)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.top, 20)
            
            .offset(x: showSettings ? 400 : 0)
            .opacity(showLearnSets ? 0 : 1)
            .offset(y: showProfile ? 130 : 0)
            .opacity(showBuild ? 0 : 1)
            .opacity(showPlaySets ? 0 : 1)
            
            SettingsView(showSettings: $showSettings)
                .offset(x: showSettings ? 0 : -600)
                .scaleEffect(showSettings ? 1 : 0.5)
            
            BuilderView(showBuild: $showBuild)
            .opacity(showBuild ? 1 : 0)
                .offset(x: showBuild ? 0 : -400)
            
            LearnSetsView(setIndex: $setIndex, showLearnSets: $showLearnSets, showLearn: $showLearn)
                .offset(x: showLearnSets ? 0 : -400)
                .opacity(showLearnSets ? 1 : 0)
                .opacity(showLearn ? 0 : 1)
            
            PlaySetsView(setIndex: $setIndex, showPlaySets: $showPlaySets, showPlay: $showPlay, randomNumber: $randomNumber, cardInteger: $cardInteger, questions: $questions, answer1: $answer1, answer2: $answer2, total: $total)
            .offset(x: showPlaySets ? 0 : -400)
            .opacity(showPlaySets ? 1 : 0)
            .opacity(showPlay ? 0 : 1)
            
            PlayTruthView(showPlay: $showPlay, cardInteger: $cardInteger, setIndex: $setIndex, randomNumber: $randomNumber, questions: $questions, answer1: $answer1, answer2: $answer2, correctCounter: $correctCounter, showResults: $showResults, total: $total)
                .offset(x: showPlay ? 0 : -400)
                .opacity(showPlay ? 1 : 0)
            
            UserProfileView(userName: profileName)
                                .offset(y: showProfile ? -410 : -800)
                .scaleEffect(showProfile ? 1 : 0.7)
            
            LearnView(showLearn: $showLearn, setIndex: $setIndex, cardInteger: $cardInteger, showQuestion: $showQuestion)
                .opacity(showLearn ? 1 : 0)
            
            
        }
        .animation(.easeInOut(duration: 0.3))
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return MenuView(showSettings: false, showProfile: false, showLearn: false, showLearnSets: false, showBuild: false).environment(\.managedObjectContext, context)
    }
}

let screen = UIScreen.main.bounds

