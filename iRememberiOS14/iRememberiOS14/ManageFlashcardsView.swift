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
    @State var edit = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(flashcardSets, id: \.self){ set in
                    if device.contains("iPad"){
                        NavigationLink(destination:List{
                                        HStack{Text("Question").frame(maxWidth: 500).font(.title)
                                            Spacer()
                                            Text("Answer").frame(maxWidth: 500)
                                        }.font(.title)
                                        ForEach(set.flashcardArray, id: \.self){flashcard in
                            HStack{
                                LazyVStack{
                                    Text(flashcard.wrappedQuestion).font(.system(size: 20))
                                }.frame(maxWidth: 500)
                                Spacer()
                                LazyVStack {
                                    Text(flashcard.wrappedAnswer).font(.system(size: 20))
                                }.frame(maxWidth: 500)
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
                        }}){
                            Text("\(set.wrappedName)")
                        }
                    }else{
                    DisclosureGroup("\(set.wrappedName)"){
                        ForEach(set.flashcardArray, id: \.self){flashcard in
                            HStack{
                                LazyVStack{
                                    Text(flashcard.wrappedQuestion)
                                }.frame(maxWidth: 320)
                                Spacer()
                                LazyVStack {
                                    Text(flashcard.wrappedAnswer)
                                }.frame(maxWidth: 320)
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
                    }}
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
                                    Button(action: {
                                        if lastSet>=flashcardSets.count{
                                            lastSet=0
                                        }
                                            self.showAddFlashcard.toggle()}){
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
let device = UIDevice.current.model
