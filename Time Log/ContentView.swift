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
                Button("1"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("2"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("3"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("Clear"){}.frame(maxWidth: .infinity, maxHeight: 50)
            }
            HStack {
                Button("4"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("5"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("6"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("-"){}.frame(maxWidth: .infinity, maxHeight: 50)
                    
            }
            HStack {
                Button("7"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("8"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("9"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("+"){}.frame(maxWidth: .infinity, maxHeight: 50)
            }
            HStack(alignment: .firstTextBaseline) {
                Button("0"){}.frame(maxWidth: .infinity, maxHeight: 50)
                Button("="){}.frame(maxWidth: .infinity, maxHeight: 50)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
