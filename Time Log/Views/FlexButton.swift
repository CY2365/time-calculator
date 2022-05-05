//
//  FlexButton.swift
//  Time Log
//
//  Created by Cenk Yavuz on 26/04/2022.
//

import SwiftUI

struct FlexButton: View {
    
    var text: String
    let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
            
        if text == "0" || text == "=" {
            Button(text, action: action)
                .buttonStyle(RectButton(text: text))
        } else {
            Button(text, action: action)
                .buttonStyle(SquareButton(text: text))
        }
        
    }
}

struct SquareButton: ButtonStyle {
    let text: String
    
    func makeBody(configuration: Configuration) -> some View {
        var color: Color = .buttonBackground
        var foreground: Color = ButtonLets.foreground
        
        var theButton: some View {
            ZStack{
                configuration.isPressed ? ButtonLets.pressedColor : color
                configuration.label
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(foreground)
            .cornerRadius(ButtonLets.cornerRadius)
            .font(ButtonLets.buttonFont)
            .overlay(RoundedRectangle(cornerRadius: ButtonLets.cornerRadius)
            .stroke(Color.black, lineWidth: ButtonLets.borderWidth))
            .shadow(radius: ButtonLets.shadowRadius)
            
        }
        
        switch text {
        case "AC", "C":
            color = .clearButton
        case "-":
            foreground = .red
        case "+":
            foreground = .green
        default:
            color = .buttonBackground
            foreground = ButtonLets.foreground
        }
            
        return theButton
    }
}

struct RectButton: ButtonStyle {
    let text: String
    
    func makeBody(configuration: Configuration) -> some View {
        var color: Color
        var theButton: some View {
            ZStack {
                configuration.isPressed ? ButtonLets.pressedColor : color
                configuration.label
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(2, contentMode: .fit)
            .foregroundColor(ButtonLets.foreground)
            .cornerRadius(ButtonLets.cornerRadius)
            .font(ButtonLets.buttonFont)
            .overlay(RoundedRectangle(cornerRadius:ButtonLets.cornerRadius)
            .stroke(Color.black, lineWidth: ButtonLets.borderWidth))
            .shadow(radius: ButtonLets.shadowRadius)
        }
        
        if text == "=" {
            color = .orange
        } else {
            color = .buttonBackground
        }
        
        return theButton
    }
}

enum ButtonLets {
    static let shadowRadius: CGFloat = 1
    static let cornerRadius: CGFloat = 5
    static let borderWidth: CGFloat = 0.5
    static let foreground: Color = .white
    static let pressedColor: Color = .white
    static let buttonFont: Font = Font.system(size: 20, weight: .bold, design: .monospaced)
}



//struct FlexButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FlexButton("0"){}
//
//    }
//}
