//
//  ContentView.swift
//  Time Log
//
//  Created by Cenk Yavuz on 26/04/2022.
//

import SwiftUI

let testArray: [String] = ["1", "2", "3", "Clear", "4", "5", "6", "-", "7", "8", "9", "+", "0", "="]
var currentIndex = 0
var rows: [GridItem] = [GridItem(.adaptive(minimum: 50))]

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                FlexButton("1"){}
                FlexButton("2"){}
                FlexButton("3"){}
                FlexButton("Clear"){}
            }
            HStack {
                FlexButton("4"){}
                FlexButton("5"){}
                FlexButton("6"){}
                FlexButton("-"){}
            }
            HStack {
                FlexButton("7"){}
                FlexButton("8"){}
                FlexButton("9"){}
                FlexButton("+"){}
            }
            HStack(alignment: .firstTextBaseline) {
                FlexButton("0"){}
                FlexButton("="){}
        }
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
