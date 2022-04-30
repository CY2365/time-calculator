//
//  Time_LogApp.swift
//  Time Log
//
//  Created by Cenk Yavuz on 26/04/2022.
//

import SwiftUI

@main
struct Time_LogApp: App {
    
    @StateObject var calculator: Calculator = Calculator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(calculator)
        }
    }
}
