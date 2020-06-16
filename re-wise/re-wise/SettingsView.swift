//
//  SettingsView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 30/04/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button (action: {self.showSettings.toggle()}) {
                    Image(systemName: "multiply")
                        .resizable()
                        .foregroundColor(Color.black)
                        .clipped()
                        .frame(width:30, height: 30)
                        .padding()
                        .offset(y:10)
                }
            }
            Spacer()
        }
        .frame(width: screen.width-25, height: screen.height-50)
        .background(LinearGradient(gradient: Gradient(colors: [darkBlue, lightBlue]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(1))
        
        .clipShape(RoundedRectangle(cornerRadius: 30))
            .blendMode(.hardLight)
        .padding(.top, 20)
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettings: .constant(true))
    }
}
