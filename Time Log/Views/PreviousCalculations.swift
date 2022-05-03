//
//  PreviousCalculations.swift
//  Time Log
//
//  Created by Cenk Yavuz on 30/04/2022.
//

import SwiftUI

struct PreviousCalculations: View {
    @Binding var showHistory: Bool
    @EnvironmentObject var calculator: Calculator
    private let pasteBoard = UIPasteboard.general
    @State var copiedTextVisible = false
    
    var body: some View {
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
                    ForEach(calculator.calculations) {calculation in
                        Label {
                            Text("\(calculation.firstTime + " " + calculation.operation + " " + calculation.secondTime + " = " + calculation.result)")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                                
                        } icon: {
                            Image(systemName: "doc.on.doc.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                                .padding(.trailing, 2.0)
                                .onTapGesture {
                                    copy("\(calculation.firstTime + " " + calculation.operation + " " + calculation.secondTime + " = " + calculation.result)")
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

//struct PreviousCalculations_Previews: PreviewProvider {
//    var content = CalculatorView()
//    static var previews: some View {
//        PreviousCalculations(showHistory: content.$showHistory)
//    }
//}
