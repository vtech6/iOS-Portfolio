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
    var body: some View {
        TabView {
            ForEach(set.flashcardArray, id: \.self){flashcard in
                FlashcardView(question: flashcard.wrappedQuestion, answer: flashcard.wrappedAnswer)
            }
        }
                    .tabViewStyle(PageTabViewStyle())
    }
}

struct FlashcardView: View {
    @State var question: String
    @State var answer: String
    @State var showAnswer = false
    var body: some View {
        Text(showAnswer ? answer : question).font(device.contains("iPad") ? .system(size: 20) : .body)
            .frame(maxWidth: .infinity)
            .frame(height: screen.height)
            .background(Color.white.opacity(0.01))
            .onTapGesture {
                showAnswer.toggle()
            }.onAppear {
                showAnswer = false
            }
    }
}
