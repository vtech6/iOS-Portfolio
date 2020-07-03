//
//  LoadingRingView.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 05/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct ProgressRingView: View {
    var end: CGFloat
    var scale: CGFloat
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.9), style: StrokeStyle(lineWidth: 14, lineCap: .round, miterLimit: .infinity, dash: [1, 0], dashPhase: 0))
                .frame(width: 100*scale, height: 100*scale)
            
            Circle()
                .trim(from: 0, to: end)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading), style: StrokeStyle(lineWidth: 12, lineCap: .round, miterLimit: .infinity, dash: [1, 0], dashPhase: 0))
                .frame(width:100*scale, height: 100*scale)
        }
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView(end: 0.7, scale: 0.7)
    }
}
