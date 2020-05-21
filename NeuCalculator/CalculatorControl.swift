//
//  CalculatorControl.swift
//  NeuCalculator
//
//  Created by Mikolaj Witkowski on 19/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//

import SwiftUI

func sum (a: Float64, b: Float64) -> Float64 {
    return Float64(a) + Float64(b)
}

func subtract (a: Float64, b: Float64) -> Float64 {
    return Float64(a) - Float64(b)
}

func divide (a: Float64, b: Float64) -> Float64 {
    return Float64(a) / Float64(b)
}

func multiply (a: Float64, b: Float64) -> Float64 {
    return Float64(a) * Float64(b)
}

func clear () -> Float64{
    return 0
}
func power (a: Float64, b: Float64) ->Float64{
    return pow(a, b)
}

let allFunctions = [sum, subtract, divide, multiply]

func equals (functionName: String, integerOne: Float64, integerTwo: Float64) -> Float64{
    switch functionName{
    case "sum":
        return sum(a: integerOne, b: integerTwo)
        
    case "subtract":
        return subtract(a: integerOne, b: integerTwo)
        
    case "multiply":
        return multiply(a: integerOne, b: integerTwo)
        
    case "divide":
        return divide(a: integerOne, b: integerTwo)
        
    case "power":
        return power(a: integerOne, b: integerTwo)
        
    default:
        return clear()
    }
    
}

var globalInput = 0
