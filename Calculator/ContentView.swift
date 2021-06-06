//
//  ContentView.swift
//  Calculator
//
//  Created by Mansa Pratap Singh on 06/06/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var isFinalResult = false
    var numbers: [[NumberButtons]] = [
        [.clear, .negative,.percent, .divide],
        [.seven, .eight,.nine, .multiply],
        [.four, .five,.six, .minus],
        [.one, .two,.three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    @State var firstNumber = 0.0
    @State var result = "0"
    @State var operate = ""
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(result).font(.system(size: 50)).bold().foregroundColor(.white)
                }.padding()
                ForEach(numbers, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { number in
                            ZStack {
                                Button(action: {
                                    onTap(number: number)
                                },
                                label: {
                                    Text(number.rawValue)
                                        .padding()
                                        .font(.largeTitle).foregroundColor(Color(.label))
                                        .frame(width: number.buttonWidth, height: number.buttonHeight)
                                        .background(number.buttonColor)
                                        .clipShape(RoundedRectangle(cornerRadius: number.buttonHeight/2))
                                })
                            }
                        }
                    }
                }
            }.padding()
        }.background(Color(.black)).ignoresSafeArea()
    }
    
    func onTap(number: NumberButtons) {
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
                firstNumber = Double(result) ?? 0
                result = number.rawValue
                operate = number.rawValue
            default: return
            }
        case .decimal:
            if !result.contains(".") {
                result += number.rawValue
            }
        case .equal:
            isFinalResult = true
            switch operate {
            case "/": return result = String(format: "%.2f", (firstNumber / (Double(result)!)))
            case "x": return result = String(format: "%.2f", (firstNumber * (Double(result)!)))
            case "-": return result = "\(firstNumber - (Double(result)!) )"
            case "+": return result = "\(firstNumber + (Double(result)!) )"
            default: break
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
        case .divide, .multiply, .minus, .plus, .equal: return .orange
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
