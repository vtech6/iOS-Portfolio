//
//  ContentView.swift
//  AlgoVisualizer
//
//  Created by Mikolaj Witkowski on 09/06/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

func mergeSort(array: [Int]) -> [Int]{
                    guard array.count > 1 else{
                        return array
                    }

                    let leftArray = Array(array[0..<array.count/2])
                    let rightArray = Array(array[array.count/2..<array.count])

                    return merge(left: mergeSort(array: leftArray), right: mergeSort(array: rightArray))
                }

                func merge(left: [Int], right: [Int])->[Int]{
                    var mergedArray = [Int]()
                    var left = left
                    var right = right

                    while left.count > 0 && right.count > 0{
                            if left.first! < right.first!{
                                mergedArray.append(left.removeFirst())
                            }else{
                                mergedArray.append(right.removeFirst())
                            }
                    }
                    return mergedArray + left + right
                }

func generateRandomArray() -> [Int] {
    var array = [Int]()
    for _ in 0..<40{
        let randomInt = Int(arc4random_uniform(UInt32(100)))
        array.append(randomInt)
    }
    return array
}

struct BubbleSortView: View {
    @State var array = generateRandomArray()
    @State var newArray = [Int]()
    @State var highlight = 0
    @State var done = false
    
    var body: some View {
        VStack (spacing: 20){
            HStack (alignment: .bottom, spacing: 0) {
                HStack (alignment: .bottom, spacing: 5){
                    ForEach(array, id: \.self) { item in
                        Text("")
                            .frame(width: 4, height: CGFloat(item*3))
                            .background(self.done || self.newArray.contains(item)  ? Color.blue : Color.red)
                            
                        .padding(0)
                    }
                    
                }
            }.frame(width: 500)
                .background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.4))
            Button(action: {
                let sortedArray = mergeSort(array: self.array)
                var i = 0
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true){ timer in
                    
                if i<self.array.count {
                    for j in 1..<self.array.count - i {
                        if self.array[j] < self.array[j-1] {
                            
                            let tmp = self.array[j-1]
                            self.array[j-1] = self.array[j]
                            self.array[j] = tmp
                            self.newArray.append(self.array[j])
                    }
                  }
                    i+=1
                    
                    print(i)
                    if sortedArray == self.array {
                        timer.invalidate()
                        self.done.toggle()
                    }
                }
                }
                }){
                    Text("Sort!")
                        .font(.custom("avenir", size: 20))
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.black)
                    .background(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                    .clipShape(Capsule())
                    .shadow(color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)).opacity(0.3), radius: 5, x: -1, y: -1)
            }
            
                
            
        }.animation(.easeInOut)
    }
}

struct BubbleSortView_Preview: PreviewProvider {
    static var previews: some View {
        BubbleSortView()
    }
}
