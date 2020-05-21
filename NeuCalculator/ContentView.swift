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
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 30)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color.gray)
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
                        
                        Button(action:{
                            self.previousNumber = self.currentNumber
                            self.currentNumber="0"
                            self.currentFunction = "power"
                        })
                        {SymbolView(symbolString: "^")}
                        Spacer()
                        
                        Button(action:{
                            self.previousNumber = self.currentNumber
                            if !self.currentNumber.contains("."){self.currentNumber+="."}
                        })
                        {
                            SymbolView(symbolString: ".")
                            
                        }
                        Spacer()
                        Button(action:{
                            self.previousNumber = self.currentNumber
                            self.currentNumber = "0"
                            self.currentFunction = "divide"
                            
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
                            self.previousNumber = self.currentNumber
                            self.currentNumber = "0"
                            self.currentFunction = "multiply"
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
                        Button(action: {
                            self.previousNumber = self.currentNumber
                            self.currentNumber = "0"
                            self.currentFunction = "subtract"
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
                        Button(action: {
                            self.previousNumber = self.currentNumber
                            self.currentNumber = "0"
                            self.currentFunction = "sum"
                        }){
                            ButtonView(iconName: "plus")
                        }
                    }
                    Spacer()
                    HStack(){
                        
                        ZeroView(currentNumber: $currentNumber, digit: 0)
                        Spacer()
                        
                        
                        Spacer()
                        Button(action: {
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
            Circle()
                .foregroundColor(Color(#colorLiteral(red: 0.7390441298, green: 0.7346524596, blue: 0.7424209714, alpha: 1)))
                .shadow(color: Color.white.opacity(0.35), radius: 6, x: -4, y: -4)
                .shadow(color: Color.black.opacity(0.35), radius: 6, x: 4, y: 4)
                .frame(width: buttonSize[0], height: buttonSize[0])
            
            
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
                    .foregroundColor(.black)
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
            RoundedRectangle(cornerRadius: .infinity)
                .foregroundColor(Color(#colorLiteral(red: 0.7390441298, green: 0.7346524596, blue: 0.7424209714, alpha: 1)))
                .shadow(color: Color.white.opacity(0.35), radius: 6, x: -4, y: -4)
                .shadow(color: Color.black.opacity(0.35), radius: 6, x: 4, y: 4)
                .frame(width: buttonSize[0]*4.2, height: buttonSize[0]*0.9)
            
            
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
                    .foregroundColor(.black)
                    .frame(width: buttonSize[1], height: buttonSize[1])
            }
        }
    }
}

struct MiscView: View {
    @Binding var currentNumber: String
    @State var digit: Int
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(#colorLiteral(red: 0.8426927924, green: 0.8376840949, blue: 0.8465434909, alpha: 0.6571061644)))
                .shadow(color: Color.white.opacity(0.35), radius: 6, x: -4, y: -4)
                .shadow(color: Color.black.opacity(0.35), radius: 6, x: 4, y: 4)
                .frame(width: buttonSize[0], height: buttonSize[0])
            
            
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
                    .foregroundColor(.black)
                    .frame(width: buttonSize[1], height: buttonSize[1])
            }
        }
    }
}

var buttonSize: [CGFloat] = [58, 43]
