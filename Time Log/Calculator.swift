//
//  Calculator.swift
//  Time Log
//
//  Created by Cenk Yavuz on 29/04/2022.
//

import Foundation
import SwiftUI

class Calculator: ObservableObject {
    
    @Published var calculations: [Calculation] = []
    @Published var time: String = "0:00"
    
    var firstNumber: Double = 0.0
    var secondNumber: Double = 0.0
    var result: Double = 0.0
    var isNewCalculation = true
    var isShowingResult = false
    var operation: String?
    var numbers: [String] = []
    
    func arrayToDouble(from array: [String]) -> Double {
        var hour: Double = 0.0
        var minute: Double = 0.0
        
        if array.count >= 3 {
            hour = Double(array.prefix(upTo: array.count - 2).joined())!
            minute = Double(array.suffix(2).joined())! / 60
        }
        if array.count == 2 {
            if let safeMinute = Double(array.joined()) {
                minute = safeMinute / 60
            }
        }
        if array.count == 1 {
            if let safeMinute = Double(array.joined()) {
                minute = safeMinute / 60
            }
        }
        
        let total = hour + minute
        return total
    }
    
    func checkIfSingleDigit(_ minute: String) -> String {
        if minute.count == 1 {
            let doubleDigit = minute + "0"
            return doubleDigit
        } else {
            return minute
        }
    }
    
    func doubleToTime(_ number: Double?) -> String? {
        if let safeNumber = number {
            let remainder = safeNumber.truncatingRemainder(dividingBy: 1)
            let hour = Int(ceil(safeNumber - remainder))
            let minute = remainder * 60.0
            let total = "\(hour):\(minute)"
            return total
            
            
        } else {
            return nil
        }
    }
    
    
    func checkInput(_ input: String) -> Void {
        switch input {
        case "+", "-" :
            operation = input
            if isNewCalculation && isShowingResult {
                firstNumber = result
                isNewCalculation = false
            } else if isNewCalculation && !isShowingResult {
                firstNumber = arrayToDouble(from: numbers)
                isNewCalculation = false
                resetTime()
            } else if !isNewCalculation && !isShowingResult {
                secondNumber = arrayToDouble(from: numbers)
                calculate()
                firstNumber = result
                isNewCalculation = true
                isShowingResult = true
            }
            
        case "=":
            if isShowingResult {
                firstNumber = result
            } else {
                secondNumber = arrayToDouble(from: numbers)
            }
            
            calculate()
            isNewCalculation = true
            isShowingResult = true
                
                
        case "AC", "C":
            resetTime()
            
        default:
            if isNewCalculation && isShowingResult {
                resetTime()
            }
            numbers.append(input)
            renderNumbers()
            isShowingResult = false
        }
    }
    
    
    func renderNumbers() {
        if numbers.count == 1 {
            time = "0:0" + numbers.first!
        } else if numbers.count == 2 {
            time = "0:" + numbers[0] + numbers[1]
        } else if numbers.count >= 3 {
            let indexSecondLast = numbers.count - 2
            let hourArray = numbers.prefix(indexSecondLast)
            time = hourArray.joined() + ":" + numbers[indexSecondLast] + numbers.last!
        } else {
            time = "0:00"
        }
    }
    
    func calculate() -> Void {
        if operation == "+" {
            result = firstNumber + secondNumber
            let timeOne = doubleToTime(firstNumber)
            let timeTwo = doubleToTime(secondNumber)
            let result = doubleToTime(result)
            if timeOne != nil && timeTwo != nil && result != nil {
                let calc = Calculation(firstTime: timeOne!, secondTime: timeTwo!, operation: "+", result: result!)
                calculations.append(calc)
                time = calc.result
            }
            
        } else if operation == "-" {
            result = firstNumber - secondNumber
            let timeOne = doubleToTime(firstNumber)
            let timeTwo = doubleToTime(secondNumber)
            let result = doubleToTime(result)
            if timeOne != nil && timeTwo != nil && result != nil {
                let calc = Calculation(firstTime: timeOne!, secondTime: timeTwo!, operation: "-", result: result!)
                calculations.append(calc)
                time = calc.result
            }
        } else {
            return
        }
    }
    
    func resetTime() {
        time = "0:00"
        numbers = []
        
    }
}
