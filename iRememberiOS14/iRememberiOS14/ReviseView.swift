//
//  ReviseView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 29/06/2020.
//

import SwiftUI

struct ReviseView: View {
    @Binding var showRevise: Bool
    @State var set: FlashcardSet
    @State var showAnswer = false
    var body: some View {
        TabView {
            ForEach(set.flashcardArray, id: \.self){flashcard in
                Text(showAnswer ? flashcard.wrappedAnswer : flashcard.wrappedQuestion)
                    .frame(maxWidth: .infinity)
                    .frame(height: screen.height)
                    .background(Color.white.opacity(0.01))
                    .onTapGesture {
                    showAnswer.toggle()
                }
            }
        }
                    .tabViewStyle(PageTabViewStyle())
    }
}
