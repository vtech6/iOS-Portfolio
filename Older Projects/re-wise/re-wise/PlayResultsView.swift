//
//  PlayResultsView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 15/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct PlayResultsView: View {
    @Binding var cardInteger: Int
    @Binding var setIndex: Int
    @Binding var correctCounter: Int
    @Binding var showResults: Bool
    @Binding var total: Int
    @Binding var showPlay: Bool
    var body: some View {
        Button(action: {
            self.showResults.toggle()
            self.showPlay.toggle()
            self.correctCounter=0
            self.cardInteger=0
            
        }) {
            VStack(spacing: 7) {
                Text("You Scored: \(self.correctCounter) out of \(self.total).")
                    .font(.body)
                if self.correctCounter==self.total{
                    Text("You're amazing!")
                }
                else if self.correctCounter >= (Int(0.5 * Double(self.total))) {
                    Text("Keep it up!")
                }
                else {
                    Text("Better luck next time!")
                }
                Spacer()
                Text("Press to continue")
                    .font(.subheadline)
                }.padding()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
            .frame(width: 250, height: 100)
            .background(lightPink)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct PlayResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayResultsView(cardInteger: .constant(0), setIndex: .constant(0), correctCounter: .constant(4), showResults: .constant(true), total: .constant(0), showPlay: .constant(true))
    }
}
