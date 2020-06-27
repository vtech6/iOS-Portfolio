//
//  ContentView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 25/06/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        FlashcardListView()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
