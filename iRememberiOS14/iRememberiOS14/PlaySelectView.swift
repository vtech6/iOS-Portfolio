//
//  PlaySelectView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 26/06/2020.
//

import SwiftUI

struct PlaySelectView: View {
    //CoreData
    @Environment (\.managedObjectContext) var moc
    @FetchRequest(entity: FlashcardSet.entity(), sortDescriptors: []) var flashcardSets: FetchedResults<FlashcardSet>
    
    //States for user input
    @State var showPlay = false
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(flashcardSets, id: \.self){ set in
                    NavigationLink(destination: PlayView(showPlay: $showPlay, set: set, answers: ["", ""])) {
//                        PlayView(showPlay: $showPlay, set: set)
//                        ForEach(0..<set.flashcardArray.count ){index in
//                            Text("\(set.flashcardArray[index].wrappedAnswer)")
                        Text("\(set.wrappedName)")
                        
                        
                        
                    }
                    .navigationBarTitle("Play")
                }
            }.listStyle(GroupedListStyle())
            
        }
//        .sheet(isPresented: $showPlay){
//            PlayView(showPlay: $showPlay).environment(\.managedObjectContext, self.moc)
//        }
    }
}

struct PlaySelectView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return PlaySelectView().environment(\.managedObjectContext, context)
    }
}
