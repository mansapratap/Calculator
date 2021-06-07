//
//  NumberButtons.swift
//  Calculator
//
//  Created by Mansa Pratap Singh on 07/06/21.
//

import SwiftUI

enum NumberButtons: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case decimal = "."
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "/"
    case negative = "±"
    case clear = "AC"
    case percent = "%"
    case equal = "="
    
    var buttonColor: Color {
        switch self {
        case .clear, .negative, .percent: return Color(.lightGray)
        case .divide, .multiply, .minus, .plus, .equal: return Color(.systemOrange).opacity(0.8)
        default: return Color(.darkGray)
        }
    }
    
    var buttonWidth: CGFloat {
        switch self {
        case .zero: return (UIScreen.main.bounds.width/2 - 10)
        default: return UIScreen.main.bounds.width/4 - 10
        }
    }
    
    var buttonHeight: CGFloat {
        switch self {
        case .zero: return (UIScreen.main.bounds.width/4 - 10)
        default: return UIScreen.main.bounds.width/4 - 10
        }
    }
}
