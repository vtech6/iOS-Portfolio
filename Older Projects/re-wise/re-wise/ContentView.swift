//
//  ContentView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 29/04/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
   
    var body: some View {
        MenuView(showSettings: false, showProfile: false, showLearn: false, showLearnSets: false, showBuild: false, showPlaySets: false, showPlay: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
