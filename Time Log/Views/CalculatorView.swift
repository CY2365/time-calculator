//
//  CalculatorView.swift
//  Time Log
//
//  Created by Cenk Yavuz on 26/04/2022.
//

import SwiftUI


var currentIndex = 0

struct CalculatorView: View {
    
    @EnvironmentObject var calculator: Calculator
    @State var showHistory = false
    @State var showInfo = false
    
    var body: some View {
        ZStack {
            Color.calculatorBackground
                .ignoresSafeArea()
            VStack(spacing: 2.0) {
                topLeftButton
                Spacer()
                calculationStack
                buttons
            }
        }
    }
    
    
    
    private var calculationStack: some View {
        VStack {
            HStack {
                Spacer()
                
                if calculator.isFirstNumber {
                    Text("")
                } else if !calculator.isFirstNumber && !calculator.isShowingResult {
                    Text("\(calculator.firstTime ?? "")")
                        .transition(.asymmetric(insertion: .offset(x: 0, y: -15), removal: .identity))
                    Text("\(calculator.operation ?? "")")
                        .transition(.asymmetric(insertion: .offset(x: 0, y: -15), removal: .identity))
                } else if calculator.isShowingResult {
                    Text("\(calculator.calculations.last?.firstTime ?? "")")
                        .transition(
                            .asymmetric(insertion: .offset(x: 0, y: -15),
                                        removal: .identity))
                    Text("\(calculator.calculations.last?.operation ?? "")")
                        .transition(
                            .asymmetric(insertion: .offset(x: 0, y: -15),
                                        removal: .identity))
                    Text("\(calculator.calculations.last?.secondTime ?? "")")
                        .transition(
                            .asymmetric(insertion: .offset(x: 0, y: -15),
                                        removal: .identity))
                }
                
            }
            Divider()
            HStack {
                Spacer()
                Text("\(calculator.time)")
                    .animation(.none)
                    .transition(.identity)
                    .font(.system(size: 36))
                    .multilineTextAlignment(.trailing)
                Button {
                    calculator.checkInput("Del")
                } label: {
                    Image(systemName: "delete.left.fill")
                }
                .padding(.trailing, 10.0)
                .foregroundColor(.blue)
            }
        }
        .padding(.bottom)
        .foregroundColor(.white)
    }
    
    private var buttons: some View {
        ForEach(calculator.buttonsArray, id: \.self) { row in
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
                self.showHistory.toggle()
            } label: {
                Label("List of previous calculations", systemImage: "list.bullet.rectangle.portrait.fill").labelStyle(.iconOnly)
            }
            .padding()
            .font(.system(size: 24))
            .sheet(isPresented: $showHistory) {
                PreviousCalculations(showHistory: $showHistory)
            }
            Spacer()
            Button {
                self.showInfo.toggle()
            } label: {
                Image(systemName: "gearshape.fill")
            }
            .padding()
            .font(.system(size: 24))
            .sheet(isPresented: $showInfo) {
                Settings($showInfo)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView().environmentObject(Calculator())
//        ContentView()
//            .previewDevice("iPod touch (7th generation)")
//        ContentView()
//            .previewDevice("iPhone 13 Pro Max")
    }
}
