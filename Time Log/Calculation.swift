//
//  Calculation.swift
//  Time Log
//
//  Created by Cenk Yavuz on 27/04/2022.
//

import Foundation

struct Calculation: Identifiable{
    
    let id = UUID()
    let firstTime: String
    let secondTime: String
    let operation: String
    var result: String
    
}
