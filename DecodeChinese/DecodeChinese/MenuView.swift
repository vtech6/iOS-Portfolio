//
//  MenuView.swift
//  DecodeChinese
//
//  Created by Mikolaj Witkowski on 03/09/2020.
//

//Not a part of the assignment, right?

import SwiftUI

struct MenuView: View {
    @State var selectedTab = "Meaniningless"
    @State var words: [Word] = []
    var body: some View {
        Text("\(selectedTab)")
            
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


