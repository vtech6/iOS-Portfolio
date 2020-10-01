//
//  ImageDetailView.swift
//  DecodeChinese
//
//  Created by Mikolaj Witkowski on 04/09/2020.
//

import SwiftUI

struct ImageDetailView: View {
    //Below is the custom method that allows us to magnify and inspect the images.
    @State var image: String
    @Binding var showImageDetail:Bool
    @State var itemScale: CGFloat = 1.0
    @State var lastScaleValue: CGFloat = 1.0
    @State var offset = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero
    
    var customMagnification: some Gesture {
        
        MagnificationGesture()
            .onChanged {
                val in
                let delta = val / self.lastScaleValue
                self.lastScaleValue = val
                self.itemScale = self.itemScale * delta
            }
            .onEnded { val in
                self.lastScaleValue = 1.0
                if self.itemScale > 3 {
                    self.itemScale = 3
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                }
                if self.itemScale < 1.5 {
                    self.itemScale = 1
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                }
            }
    }
    
    //Our custom drag gesture makes it impossible for user to swipe out of the boundaries and signals the range with haptic feedback.
    
    var customDrag: some Gesture {
        DragGesture()
            .updating($dragOffset, body: { (value, state, transaction) in
                
                state = value.translation
            })
            .onEnded({ (value) in
                self.offset.height += value.translation.height
                self.offset.width += value.translation.width
                if self.offset.width>100 {
                    self.offset.width=100
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                }
                if self.offset.width < -100 {
                    self.offset.width = -100
                    
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                }
                if self.offset.height>100 {
                    self.offset.height=100
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                }
                if self.offset.height < -100 {
                    self.offset.height = -100
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                }
            })
    }
    
    var body: some View {
        ZStack {
            VStack{
                Image(image)
                    .resizable()
                    .animation(nil)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: screen.height-200)
                    .scaleEffect(x: itemScale, y: itemScale)
                    .offset(x: self.itemScale == 1 ? 0 : offset.width + dragOffset.width, y: self.itemScale == 1 ? 0 : offset.height+dragOffset.height)
                    .gesture(
                        customMagnification.simultaneously(with: itemScale == 1.0 ? nil : customDrag)
                    )
                //This is a placeholder for any image description that could be added to the JSON.
                Text("Oracle Bone Script").font(.title).opacity(itemScale==1 ? 1 : 0)
            }.animation(.spring(response: 0.4, dampingFraction: 1, blendDuration: 1.4))
            Button(action: {
                showImageDetail.toggle()
                generateHapticFeedback()
            }){
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .frame(width: 100, height: 30)
                .background(Color.white.opacity(0.001))
            }.position(x: 40, y: 40)
        }.frame(height: screen.height-50).background(Color("imageBackground"))
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(image: "", showImageDetail: .constant(false))
    }
}
