//
//  LearnSetsView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 06/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

func assignRandomColor () -> (Color){
    let colors = [Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]
    return colors.randomElement()!
}

struct LearnSetsView: View {
    @Binding var setIndex: Int
    @Binding var showLearnSets: Bool
    @Binding var showLearn: Bool
    
    var body: some View {
        return ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    VStack (spacing: 5){
                        
                        ForEach(1..<allSets.sets.count+1) { itemIndex in
                            
                            ZStack {
                                CardSetFaceView()
                                Button (action: {
                                    self.setIndex = itemIndex-1
                                    self.showLearn.toggle()
                                    
                                    print(self.setIndex)
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
                .frame(height: 800)
                .padding(.top, 70)
                
                
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
                    Button (action: {self.showLearnSets.toggle()}) {
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

struct LearnSetsView_Previews: PreviewProvider {
    static var previews: some View {
        LearnSetsView(setIndex: .constant(0), showLearnSets: .constant(false), showLearn: .constant(false))
    }
}


struct CardSetFaceView: View {
    @State var cardColor = assignRandomColor()
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(cardColor).opacity(0.7)
            .shadow(color: cardColor.opacity(0.5), radius: 5, x: 0, y: 0)
            .frame(width: 300, height: 300)
            .padding(15)
    }
}
