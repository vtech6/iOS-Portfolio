//
//  FlashcardListView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 25/06/2020.
//

import SwiftUI

struct ManageFlashcardsView: View {
    //CoreData
    @Environment (\.managedObjectContext) var moc
    @FetchRequest(entity: FlashcardSet.entity(), sortDescriptors: []) var flashcardSets: FetchedResults<FlashcardSet>
    
    //User Defaults
    @AppStorage("LastSet") var lastSet = 0
    //States for user input
    @State var showAddFlashcard = false
    var body: some View {
        NavigationView {
            List{
                ForEach(flashcardSets, id: \.self){ set in
                    DisclosureGroup("\(set.wrappedName)"){
                        ForEach(set.flashcardArray, id: \.self){flashcard in
                            LazyHStack{
                                LazyVStack{
                                    Text(flashcard.wrappedQuestion)
                                }.frame(width: (screen.width-50)/2)
                                LazyVStack {
                                    Text(flashcard.wrappedAnswer)
                                }.frame(width: (screen.width-50)/2)
                            }.multilineTextAlignment(.center)
                        }.onDelete{row in
                            func removeItem(at offsets: IndexSet) {
                                for index in offsets {
                                    let flashcard = set.flashcardArray[index]
                                    moc.delete(flashcard)
                                }
                                try? self.moc.save()
                            }
                            removeItem(at: row)
                        }
                    }
                }
                .onDelete { indexSet in
                    func removeItem(at offsets: IndexSet) {
                        for index in offsets {
                            let flashcard = flashcardSets[index]
                            moc.delete(flashcard)
                        }
                        try? self.moc.save()
                    }
                    
                    removeItem(at: indexSet)
                }
            }.listStyle(GroupedListStyle())
            .navigationBarTitle("Manage Flashcards")
            .navigationBarItems(trailing:
                                    Button(action: {self.showAddFlashcard.toggle()}){
                                        Text("Add Flashcard")
                                            .padding(.top)
                                            .padding(.horizontal)
                                    }
            )
        }.sheet(isPresented: $showAddFlashcard){
            AddFlashcardView(showAddFlashcard: $showAddFlashcard, lastSet: $lastSet).environment(\.managedObjectContext, self.moc)
        }
    }
}

struct FlashcardListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ManageFlashcardsView().environment(\.managedObjectContext, context)
    }
}

let screen = UIScreen.main.bounds
