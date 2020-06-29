//
//  ContentView.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 25/06/2020.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab){
            ManageFlashcardsView()
    .tabItem { Image(systemName: "tray.full")
        Text("Sets")
    }.tag(0)
    ReviseSelectView()
        .tabItem { Image(systemName: "book")
            Text("Revise")
        }.tag(1)
    PlaySelectView()
        .tabItem { Image(systemName: "gamecontroller")
            Text("Play")
        }.tag(2)

        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
