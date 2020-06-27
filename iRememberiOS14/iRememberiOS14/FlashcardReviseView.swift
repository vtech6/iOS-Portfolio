//
//  FlashcardReviseView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 26/06/2020.
//

import SwiftUI

struct FlashcardReviseView: View {
    @Binding var showPlay: Bool
    @State var set: FlashcardSet
    @State var flashcardIndex = 0
    @State var showAnswer = false
    var body: some View {
        Text(showAnswer ? set.flashcardArray[flashcardIndex].wrappedAnswer : set.flashcardArray[flashcardIndex].wrappedQuestion).onTapGesture {
            showAnswer.toggle()
        }
    }
}
