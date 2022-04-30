//
//  ContentView.swift
//  Time Log
//
//  Created by Cenk Yavuz on 26/04/2022.
//

import SwiftUI

let buttonsArray: [[String]] = [
    ["7", "8", "9", "AC"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+",],
    ["0", "="]
]
var currentIndex = 0

struct ContentView: View {
    
    @EnvironmentObject var calculator: Calculator
    
    
    var body: some View {
        VStack(spacing: 2.0) {
            topLeftButton
            Spacer()
            calculationStack
            buttons
        }
        .padding(10)
        .background(Color.calculatorBackground)
    }
    
    
    
    private var calculationStack: some View {
        Group {
            HStack {
                Spacer()
                Text("\(calculator.calculations.last?.firstTime ?? "")")
                Text("\(calculator.calculations.last?.operation ?? "")")
                Text("\(calculator.calculations.last?.secondTime ?? "")")
            }
            Divider()
            HStack {
                Spacer()
                Text("\(calculator.time)")
                    .font(.system(size: 36))
                    .multilineTextAlignment(.trailing)
            }
        }.foregroundColor(.white)
    }
    
    private var buttons: some View {
        ForEach(buttonsArray, id: \.self) { row in
            HStack(spacing: 2.0) {
                ForEach(row, id: \.self) { column in
                    FlexButton(column) {
                        calculator.checkInput(column)
                    }
                }
            }
        }
    }
    
    private var topLeftButton: some View {
        HStack {
            Button {
                
            } label: {
                Label("List of previous calculations", systemImage: "list.bullet.rectangle.portrait.fill").labelStyle(.iconOnly)
            }
            .padding()
            .font(.system(size: 24))
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Calculator())
//        ContentView()
//            .previewDevice("iPod touch (7th generation)")
//        ContentView()
//            .previewDevice("iPhone 13 Pro Max")
    }
}
