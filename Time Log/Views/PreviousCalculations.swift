//
//  PreviousCalculations.swift
//  Time Log
//
//  Created by Cenk Yavuz on 30/04/2022.
//

import SwiftUI

struct PreviousCalculations: View {
    
    @EnvironmentObject var calculator: Calculator
    @Binding var showHistory: Bool
    @State var copiedTextVisible = false
    private let pasteBoard = UIPasteboard.general
    
    var body: some View {
        ZStack {
            Color.calculatorBackground.ignoresSafeArea()
            VStack {
                HStack {
                    if copiedTextVisible {
                        Text("Copied!")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .semibold, design: .monospaced))
                            .animation(.easeInOut, value: copiedTextVisible)
                    }
                    Spacer()
                    Button {
                        showHistory = false
                    } label: {
                        Label("Dismiss", systemImage: "x.square.fill").labelStyle(.iconOnly)
                    }
                    .font(.system(size: 24))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        if calculator.calculations.isEmpty {
                            Text("""
                                 "Time waits for no one."
                                 """)
                                .padding()
                                .foregroundColor(.white)
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            ForEach(calculator.calculations) { calculation in
                                
                                Label {
                                    Text("\(calculation.firstTime + " " + calculation.operation + " " + calculation.secondTime + " = " + calculation.result)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .semibold, design: .monospaced))
                                        .padding(.bottom, 1.0)
                                    
                                } icon: {
                                    
                                    Button {
                                        if calculator.copyResultOnly {
                                            copy(calculation.result)
                                        } else {
                                            copy("\(calculation.firstTime + " " + calculation.operation + " " + calculation.secondTime + " = " + calculation.result)")
                                        }
                                    } label: {
                                        Image(systemName: "doc.on.doc.fill")
                                            .font(.system(size: 16))
                                            .padding(.trailing, 3)
                                    }.buttonStyle(HightlightWhenPressed())
                                }
                            }
                        }
                    }.padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
            }
            .padding(10)
            .background(Color.calculatorBackground)
        }
        
    }
    
    private func copy(_ text: String) -> Void {
        pasteBoard.string = text
        withAnimation {
            copiedTextVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    copiedTextVisible = false
                }
            }
        }
    }
}



struct PreviousCalculations_Previews: PreviewProvider {
    
    static var previews: some View {
        PreviousCalculations(showHistory: .constant(true)).environmentObject(Calculator())
    }
}
