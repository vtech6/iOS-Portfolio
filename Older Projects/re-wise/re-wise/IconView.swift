//
//  IconView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 29/04/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct IconView: View {
    var iconName: String
    var body: some View {
        VStack {
            Image(systemName: self.iconName)
            .resizable()
        }
        .frame(width: 30, height: 30)
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(iconName: "gear")
    }
}
