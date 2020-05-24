//
//  ContentView.swift
//  NeuCalculator
//
//  Created by Mikolaj Witkowski on 19/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputToggle = false
    @State var currentFunction = "clear"
    @State var currentNumber = "0"
    @State var previousNumber = "0"
    @State var nextNumber = "0"
    @State var funcMode = false
    @State var memory = ""
    
    var body: some View {
        return ZStack {
            Text("")
                .frame(width: screen.width, height: screen.height*1.5)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4402813315, green: 0.4376685023, blue: 0.4422926307, alpha: 1)),Color(#colorLiteral(red: 0.4990558624, green: 0.4970183372, blue: 0.5346681476, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10){
                Text("\(currentNumber)")
                    .font(.system(size: 50))
                Spacer()
                VStack (spacing: 6){
                    
                    
                    Spacer()
                    
                    HStack{
                        Button(action:{
                            self.currentNumber = "0"
                            self.previousNumber = "0"
                        })
                        {SymbolView(symbolString: "C")}
                        
                        Spacer()
                        
                        Button(action:{if self.funcMode{
                            self.previousNumber = String(equals(functionName: self.currentFunction, integerOne: Float64(self.previousNumber) ?? 0, integerTwo: Float64(self.currentNumber) ?? 0))
                                    self.currentNumber = "0"
                                    self.currentFunction = "power"
                        }else{
                            self.previousNumber = self.currentNumber
                            self.currentNumber="0"
                            self.currentFunction = "power"
                            self.funcMode.toggle()
                            }
                        })
                        {SymbolView(symbolString: "^")}
                        Spacer()
                        
                        Button(action:{
                            self.currentNumber = String(percent(a: self.currentNumber))
                        })
                        {SymbolView(symbolString: "%")}
                        
                        Spacer()
                        Button(action:{if self.funcMode{
                            self.previousNumber = String(equals(functionName: self.currentFunction, integerOne: Float64(self.previousNumber) ?? 0, integerTwo: Float64(self.currentNumber) ?? 0))
                                    self.currentNumber = "0"
                                    self.currentFunction = "divide"
                        }else{
                            self.previousNumber = self.currentNumber
                            self.currentNumber = "0"
                            self.currentFunction = "divide"
                            self.funcMode.toggle()
                            }
                        })
                        {ButtonView(iconName: "divide")}
                    }
                    Spacer()
                    HStack{
                        DigitView(currentNumber: $currentNumber, digit: 1)
                        Spacer()
                        DigitView(currentNumber: $currentNumber, digit: 2)
                        Spacer()
                        DigitView(currentNumber: $currentNumber, digit: 3)
                        Spacer()
                        Button(action:{
                            if self.funcMode{
                                self.previousNumber = String(equals(functionName: self.currentFunction, integerOne: Float64(self.previousNumber) ?? 0, integerTwo: Float64(self.currentNumber) ?? 0))
                                    self.currentNumber = "0"
                                    self.currentFunction = "multiply"
                            }else{
                            self.previousNumber = self.currentNumber
                            self.currentNumber = "0"
                            self.currentFunction = "multiply"
                                self.funcMode.toggle()
                            }
                        })
                        {
                            ButtonView(iconName: "multiply")
                            
                        }
                    }
                    Spacer()
                    HStack{
                        DigitView(currentNumber: $currentNumber, digit: 4)
                        Spacer()
                        DigitView(currentNumber: $currentNumber, digit: 5)
                        Spacer()
                        DigitView(currentNumber: $currentNumber, digit: 6)
                        Spacer()
                        Button(action: {if self.funcMode{
                            self.previousNumber = String(equals(functionName: self.currentFunction, integerOne: Float64(self.previousNumber) ?? 0, integerTwo: Float64(self.currentNumber) ?? 0))
                                self.currentNumber = "-"
                                self.currentFunction = "sum"
                        }else{
                            
                            self.previousNumber = self.currentNumber
                            self.currentNumber = "-"
                            self.currentFunction = "sum"
                            self.funcMode.toggle()
                            }
                        }){
                            ButtonView(iconName: "minus")
                        }
                    }
                    
                    Spacer()
                    HStack(){
                        DigitView(currentNumber: $currentNumber, digit: 7)
                        Spacer()
                        DigitView(currentNumber: $currentNumber, digit: 8)
                        Spacer()
                        DigitView(currentNumber: $currentNumber, digit: 9)
                        Spacer()
                        Button(action: {if self.funcMode{
                            self.previousNumber = String(equals(functionName: self.currentFunction, integerOne: Float64(self.previousNumber) ?? 0, integerTwo: Float64(self.currentNumber) ?? 0))
                            self.currentNumber = "0"
                            self.currentFunction = "sum"
                        }else{
                            self.previousNumber = self.currentNumber
                            self.currentNumber = "0"
                            self.currentFunction = "sum"
                            self.funcMode.toggle()
                            }
                        }){
                            ButtonView(iconName: "plus")
                        }
                    }
                    Spacer()
                    HStack(){
                        
                        ZeroView(currentNumber: $currentNumber, digit: 0)
                        Spacer()
                        Button(action:{
                            if !self.currentNumber.contains("."){self.currentNumber+="."}
                        })
                        {
                            SymbolView(symbolString: ".")
                            
                        }
                        
                        Spacer()
                        Button(action: {
                            if self.funcMode{
                                self.funcMode.toggle()
                            }
                            self.currentNumber = String(equals(functionName: self.currentFunction, integerOne: Float64(self.previousNumber) ?? 0, integerTwo: Float64(self.currentNumber) ?? 0))
                            
                            if self.currentNumber.hasSuffix(".0"){
                                self.currentNumber.removeLast(2)
                            }
                            
                        }){
                            ButtonView(iconName: "equal")
                        }
                    }
                }
                
            }.padding()
                .frame(width: screen.width, height: screen.height/1.4)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let screen = UIScreen.main.bounds

struct DigitView: View {
    @Binding var currentNumber: String
    @State var digit: Int
    var body: some View {
        ZStack {
            Text(" ")
                .frame(width: buttonSize[0], height: buttonSize[0])
                .background(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6854407191, green: 0.6896297336, blue: 0.7429966331, alpha: 0.7787885274)), Color(#colorLiteral(red: 0.5935800672, green: 0.6000974774, blue: 0.6542025805, alpha: 0.6797677654))]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: 50))
                .clipShape(Circle())
                .shadow(color: Color.white.opacity(0.35), radius: 6, x: -4, y: -4)
                .shadow(color: Color.black.opacity(0.35), radius: 6, x: 4, y: 4)
            
            
            
            Button(action: {
                
                if self.currentNumber=="0"{
                    self.currentNumber = String(self.digit)
                }else{
                    self.currentNumber += String(self.digit)
                }
            }
            ){
                Text(String(self.digit))
                    .font(.system(size: 50))
                    .foregroundColor(primary)
                    .frame(width: buttonSize[1], height: buttonSize[1])
            }
        }
    }
}

struct ZeroView: View {
    @Binding var currentNumber: String
    @State var digit: Int
    var body: some View {
        ZStack {
            Text(" ")
                .frame(width: buttonSize[0]*2.7, height: buttonSize[0]*0.9)
                .background(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6854407191, green: 0.6896297336, blue: 0.7429966331, alpha: 0.7787885274)), Color(#colorLiteral(red: 0.5935800672, green: 0.6000974774, blue: 0.6542025805, alpha: 0.6797677654))]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: 300))
                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                .shadow(color: Color.white.opacity(0.35), radius: 6, x: -4, y: -4)
                .shadow(color: Color.black.opacity(0.35), radius: 6, x: 4, y: 4)
            
            
            
            Button(action: {
                
                if self.currentNumber=="0"{
                    self.currentNumber = String(self.digit)
                }else{
                    self.currentNumber += String(self.digit)
                }
            }
            ){
                Text(String(self.digit))
                    .font(.system(size: 50))
                    .foregroundColor(primary)
                    .frame(width: buttonSize[0]*2.7, height: buttonSize[1])
            }
        }
    }
}



var buttonSize: [CGFloat] = [58, 43]
