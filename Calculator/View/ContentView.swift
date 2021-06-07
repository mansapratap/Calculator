//
//  ContentView.swift
//  Calculator
//
//  Created by Mansa Pratap Singh on 06/06/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var calculator = Calculator()
    
    var numbers: [[NumberButtons]] = [
        [.clear, .negative,.percent, .divide],
        [.seven, .eight,.nine, .multiply],
        [.four, .five,.six, .minus],
        [.one, .two,.three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(calculator.result).font(.system(size: 50)).bold().foregroundColor(Color(.label))
                }.padding()
                
                ForEach(numbers, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { number in
                            ZStack {
                                Button(action: {
                                    calculator.calculate(number: number)
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
        }.background(Color("AccentColor")).ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
