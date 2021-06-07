//
//  Calculator.swift
//  Calculator
//
//  Created by Mansa Pratap Singh on 07/06/21.
//

import SwiftUI

class Calculator: ObservableObject {
    
    @Published var isFinalResult = false
    @Published var firstNumber: Float = 0.0
    @Published var result = "0"
    @Published var operate = ""
    @Published var temp: Float = 0 {
        didSet {
            if temp.remainder(dividingBy: 1.0) == 0.0 {
                result = "\(Int(temp))"
            } else {
                result = "\(temp)"
            }
        }
    }
    
    func calculate(number: NumberButtons) {
        switch number {
        case .one,.two,.three,.four,.five,.six,.seven,.eight,.nine,.zero:
            if (result == "0" && result.count == 1) || (result == operate) || isFinalResult{
                result = number.rawValue
                isFinalResult = false
            } else if result.count < 11, !isFinalResult {
                result += number.rawValue
            } else {
                result = "0"
            }
        case .clear,.negative,.percent,.divide,.multiply,.minus,.plus:
            isFinalResult = false
            switch number {
            case .clear: return result = "0"
            case .negative: return result = "\(-(Double(result) ?? 0))"
            case .percent: return result = "\((Double(result) ?? 0)/100)"
            case .divide, .multiply, .minus, .plus:
                firstNumber = Float(result) ?? 0
                operate = number.rawValue
                result = operate
            default: return
            }
        case .decimal:
            if !result.contains("."), result != operate {
                result += number.rawValue
            } else if result == operate {
                result = "0."
            }
        case .equal:
            isFinalResult = true
            if result != "0" {
                switch operate {
                case "/": return temp = firstNumber / (Float(result) ?? 0)
                case "x": return temp = firstNumber * (Float(result) ?? 0)
                case "-": return temp = firstNumber - (Float(result) ?? 0)
                case "+": return temp = firstNumber + (Float(result) ?? 0)
                default: break
                }
            } else {
                result = "0"
            }
        }
    }
}
