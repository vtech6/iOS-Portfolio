//
//  FlashcardReviseView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 26/06/2020.
//

import SwiftUI

struct ReviseSelectView: View {
    //CoreData
    @Environment (\.managedObjectContext) var moc
    @FetchRequest(entity: FlashcardSet.entity(), sortDescriptors: []) var flashcardSets: FetchedResults<FlashcardSet>
    
    @State var showRevise = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(flashcardSets, id: \.self){ set in
                    NavigationLink(destination: ReviseView(showRevise: $showRevise, set: set)) {
                        Text("\(set.wrappedName)")
                    }
                    .navigationBarTitle("Revise")
                }
            }.listStyle(GroupedListStyle())
            
        }
    }
}
