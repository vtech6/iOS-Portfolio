//
//  MergeSortView.swift
//  AlgoVisualizer
//
//  Created by Mikolaj Witkowski on 09/06/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

//This is unfinished, I'm planning to add some more sorting algorithms but it takes time to adjust the code :)

import SwiftUI


struct MergeSortView: View {
    @State var array = generateRandomArray()
    @State var newArray = [Int]()
    @State var highlight = 0
    @State var done = false

    
    var body: some View {
        VStack {
            HStack (alignment: .bottom) {
                HStack (alignment: .bottom){
                    ForEach(array, id: \.self) { item in
                        Text("")
                            .frame(width: 1, height: CGFloat(item*3))
                            .background(self.done || self.newArray.contains(item)  ? Color.blue : Color.red)
                            
                        .padding(0)
                    }
                }
            }.frame(width: 300)
            Button(action: {
                let sortedArray = mergeSort(array: self.array)
                var i = 0
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true){ timer in
                    
                if i<self.array.count {
                    
                    i+=1
                    
                    print(i)
                    if sortedArray == self.array {
                        timer.invalidate()
                        self.done.toggle()
                    }
                }
                
                }
                
                }){
                Text("BubbleSort")
            }
            
        }.animation(.easeInOut)
    }
}

struct MergeSortView_Previews: PreviewProvider {
    static var previews: some View {
        MergeSortView()
    }
}
