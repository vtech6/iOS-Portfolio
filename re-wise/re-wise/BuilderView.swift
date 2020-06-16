//
//  BuilderView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 07/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI
import CoreData

struct newSetItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

func deleteFlashcards() {
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FlashCardDataModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
    }
    catch _ as NSError {
        // TODO: handle the error
    }
}

func displayFlashcards() -> [FlashCardDataModel] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var flashcard: [FlashCardDataModel] = []
    do{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FlashCardDataModel")
        let fetchedResult = try context.fetch(fetchRequest)
        flashcard = fetchedResult as! [FlashCardDataModel]
    }catch let error as NSError {
        print("woe grabAllPersons \(error)")
    }
    return flashcard
}

class newSet: ObservableObject {
    @Published var items = [newSetItem]()
}

struct BuilderView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(entity: FlashCardDataModel.entity(), sortDescriptors: []) var flashcards: FetchedResults<FlashCardDataModel>
    
    @State var question: String = ""
    @State var answer: String = ""
    @State var flashCardSet: [FlashCardDataModel] = []
    
    @ObservedObject var setItems = newSet()
    
    @Binding var showBuild: Bool
    
    func removeItems (at offsets: IndexSet) {
        setItems.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HomeButtonView(showBuild: $showBuild)
            }
            VStack{
                TextField("Enter your question", text: $question)
                    .background(Color.white)
                TextField("Enter your answer", text: $answer)
                    .background(Color.white)
                Button(action: {
                    self.setItems.items.insert(contentsOf: [newSetItem(question: self.question, answer: self.answer)], at:0)
                    let newFlashCard = FlashCardDataModel(context: self.managedObjectContext)
                    newFlashCard.question = self.question
                    newFlashCard.answer = self.answer
                    newFlashCard.id = UUID()
                    try? self.managedObjectContext.save()
                    print(self.flashcards)
                    self.flashCardSet = displayFlashcards()
                    
                }){
                    
                    Text("Click here to insert Q&A")
                        .foregroundColor(Color.black)
                }
            }
            HStack{
                VStack {
                    Text("Questions")
                        .font(.title)
                }
                .frame(width: 150)
                VStack {
                    Text("Answers")
                        .font(.title)
                }
                .frame(width: 150)
            }
            .padding()
            HStack{
                
                VStack {
                    ForEach(flashcards, id: \.id) { item in
                        Text(item.question ?? "Unknown")
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                .frame(width: 250)
                .multilineTextAlignment(.center)
                VStack {
                    ForEach(flashcards, id: \.id) { item in
                        Text(item.answer ?? "Unknown")
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                .frame(width: 250)
                .multilineTextAlignment(.center)

            }
            Spacer()
            HStack{
                Button(action: {
                    deleteFlashcards()
                }){
                    Text("Delete All")
                }
            }
        }
        .frame(width: screen.width-25, height: screen.height-50)
        .background(LinearGradient(gradient: Gradient(colors: [darkBlue, lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(1))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .blendMode(.hardLight)
        .padding(.top, 20)
        
    }
}

struct BuilderView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return BuilderView(showBuild: .constant(true)).environment(\.managedObjectContext, context)
    }
}

struct HomeButtonView: View {
    @Binding var showBuild: Bool
    var body: some View {
        Button (action: {self.showBuild.toggle()}) {
            Image(systemName: "house.fill")
                .resizable()
                .foregroundColor(Color.black)
                .clipped()
                .frame(width:30, height: 30)
                .padding()
                .offset(y:10)
        }
    }
}
