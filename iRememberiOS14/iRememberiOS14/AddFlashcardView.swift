//
//  AddFlashcardView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 25/06/2020.
//

import SwiftUI

struct AddFlashcardView: View {
    //CoreData
    @Environment (\.managedObjectContext) var moc
    @FetchRequest(entity: Flashcard.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Flashcard.orderNumber, ascending: true)]) var flashcards: FetchedResults<Flashcard>
    @FetchRequest(entity: FlashcardSet.entity(), sortDescriptors: []) var flashcardSets: FetchedResults<FlashcardSet>
    
    
    
    //States for user input
    @State var question: String = ""
    @State var answer: String = ""
    
    @State var setTitle: String = ""
    @State var addSet: Bool = false
    @Binding var showAddFlashcard: Bool
    @Binding var lastSet: Int
    @State var addMultiple = false
    
    var body: some View {
        NavigationView{
            Form{if let first = flashcardSets.first{
                Picker(selection: $lastSet, label: Text("Choose Set")){
                    List{
                    ForEach(0..<flashcardSets.endIndex){ i in
                        Text("\(flashcardSets[i].wrappedName)")
                    }
                }
                }}
                Section{
                    HStack {if let first = flashcardSets.first{
                        if !addSet{
                            HStack {
                                Text(flashcardSets[lastSet].wrappedName)
                                Spacer()
                                Text("Set Count: \(flashcardSets[lastSet].flashcardArray.count)")
                            }
                        }else{
                            TextField("Set Name", text: $setTitle)
                        }}else{
                            TextField("Set Name", text: $setTitle)
                        }
                    }.animation(.easeInOut(duration: 0.3))
                    TextField("Question", text: $question)
                    TextField("Answer", text: $answer)
                }
                Section{
                    Button(action: {
                        let newFlashcard = Flashcard(context: self.moc)
                        let number = self.flashcards.last?.orderNumber
                        if let number = number {
                            newFlashcard.orderNumber = number+1
                        }else{
                            newFlashcard.orderNumber = 0
                        }
                        newFlashcard.id = UUID()
                        newFlashcard.question = self.question
                        newFlashcard.answer = self.answer
                        newFlashcard.origin = FlashcardSet(context: self.moc)
                        if let first = flashcardSets.first{if !addSet{
                        newFlashcard.origin?.name = flashcardSets[lastSet].wrappedName
                        newFlashcard.origin?.shortname = flashcardSets[lastSet].wrappedName
                        }else{
                            newFlashcard.origin?.name = setTitle
                            newFlashcard.origin?.shortname = setTitle
                        }}else{
                            newFlashcard.origin?.name = setTitle
                            newFlashcard.origin?.shortname = setTitle
                        }
                        
                        try? self.moc.save()
                        if addMultiple && !addSet {
                            self.question = ""
                            self.answer = ""
                        }else{
                            self.showAddFlashcard.toggle()}
                    }){
                        Text("Add")
                    }
                }
            }.navigationBarTitle("Add Flashcard")
            .navigationBarItems(leading: Button(action:{addMultiple.toggle()}){if !addMultiple {Text("Multiple Adding Off")}else{Text("Multiple Adding On")}},
                                    trailing: Button(action:{self.addSet.toggle()}){Text("New Set")}.padding())
        }
        
    }
}


