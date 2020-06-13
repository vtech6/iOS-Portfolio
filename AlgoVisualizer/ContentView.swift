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
    @State var play = false
    
    var body: some View {
        ZStack {
            
            VStack (spacing: 20){
                HStack (alignment: .bottom, spacing: 0) {
                    HStack (alignment: .bottom, spacing: 5){
                        ForEach(array, id: \.self) { item in
                            Text("")
                                .frame(width: 5, height: CGFloat(item*3))
                                .background(self.done || self.newArray.contains(item)  ? Color.blue : Color(#colorLiteral(red: 1, green: 0.4094555676, blue: 0.2313871384, alpha: 1)))
                                
                            .padding(0)
                        }
                        .frame(width: 4)
                    }
                }.frame(width: 520)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height:3)
                        .offset(y:-20)
                        .foregroundColor(Color.white)
                        
                    
                VStack {
                    HStack {
                        Button(action: {self.array = generateRandomArray()
                            self.newArray = []
                            self.play = false
                            self.done = false
                        }){
                            Text("Shuffle!")
                                .font(.custom("avenir", size: 20))
                                .fontWeight(.semibold)
                                .frame(minWidth: 90)
                                .frame(height: 50)
                                
                                .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9373128414, green: 0.3839743733, blue: 0.2191135585, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4225026965, blue: 0.2405544221, alpha: 1)), Color(#colorLiteral(red: 0.9544101357, green: 0.3909508884, blue: 0.222997874, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                            .clipShape(Capsule())
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 1, y: 1)
                                .shadow(color: Color.white.opacity(0.4), radius: 5, x: -2, y: -2)
                                
                        }
                        Button(action: {
                            if !self.play{
                                self.play = true
                            let sortedArray = mergeSort(array: self.array)
                            var i = 0
                            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true){ timer in
                                
                                if self.play{
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
                                
                                    }}
                                else{
                                    
                                }
                            }
                            
                            }}){
                                Text("Sort!")
                                    .font(.custom("avenir", size: 20))
                                    
                                    .fontWeight(.semibold).frame(minWidth: 90)
                                    .frame(height: 50)
                                    
                                    .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9373128414, green: 0.3839743733, blue: 0.2191135585, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.421138823, blue: 0.2397958338, alpha: 1)), Color(#colorLiteral(red: 0.9544101357, green: 0.3909508884, blue: 0.222997874, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                                .clipShape(Capsule())
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 1, y: 1)
                                    .shadow(color: Color.white.opacity(0.4), radius: 5, x: -2, y: -2)
                               
                        }
                    }
                    Button(action: {self.play.toggle()}){
                        ZStack {
                            
                            Image(systemName: !self.play && !self.done ? "play" : "pause")
                            .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .offset(x: !self.play && !self.done ? 3 : 0)
                                
                                
                                .foregroundColor(.white)
                           
                            
                                .shadow(color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)).opacity(0.3), radius: 5, x: -1, y: -1).frame(width: 50, height: 50)
                                .animation(nil)
                        }.background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9373128414, green: 0.3839743733, blue: 0.2191135585, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.421138823, blue: 0.2397958338, alpha: 1)), Color(#colorLiteral(red: 0.9544101357, green: 0.3909508884, blue: 0.222997874, alpha: 1))]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 1, y: 1)
                        .shadow(color: Color.white.opacity(0.4), radius: 5, x: -2, y: -2)
                        
                    }
                }.padding()
                
                    
                
            }.animation(.easeInOut)
        }
        .frame(width: screen.width, height: screen.height+200)
        
        .background(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)).opacity(0.5))
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct BubbleSortView_Preview: PreviewProvider {
    static var previews: some View {
        BubbleSortView()
    }
}

let screen = UIScreen.main.bounds
