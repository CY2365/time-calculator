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
    @Published var buttonsArray: [[String]] = [
        ["7", "8", "9", "AC"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+",],
        ["0", "="]
    ]
    
    var firstNumber: (Int, Int) = (0, 0)
    var secondNumber: (Int, Int) = (0, 0)
    var result: (Int, Int) = (0, 0)
    var firstTime: String? = ""
    var isFirstNumber = true
    var isShowingResult = false
    var operation: String?
    var numbers: [String] = []
    var clearButton: Bool = true
    
    func arrayToInt(from array: [String]) -> (Int, Int) {
        var hour: Int = 0
        var minute: Int = 0
        
        if array.count >= 3 {
            hour = Int(array.prefix(upTo: array.count - 2).joined())!
            if let safeMinute = Int(array.suffix(2).joined()) {
                if safeMinute > 59 {
                    minute = safeMinute - 60
                    hour += 1
                } else {
                    minute = safeMinute
                }
            }
        }
        if array.count == 2 {
            if let safeMinute = Int(array.joined()) {
                if safeMinute > 59 {
                    minute = safeMinute - 60
                    hour += 1
                } else {
                    minute = safeMinute
                }
                
            }
        }
        if array.count == 1 {
            if let safeMinute = Int(array.joined()) {
                minute = safeMinute
            }
        }
        
        return (hour, minute)
    }
    
    func acToDel(){
        let some = buttonsArray[0].firstIndex(of: "AC")
        if some != nil {
            buttonsArray[0][some!] = "C"
        }
    }
    
    func delToAc() {
        let some = buttonsArray[0].firstIndex(of: "C")
        if some != nil {
            buttonsArray[0][some!] = "AC"
        }
    }
    
    func checkIfSingleDigit(_ minute: String) -> String {
        if minute.count == 1 {
            let doubleDigit = minute + "0"
            return doubleDigit
        } else {
            return minute
        }
    }
    
    func intToTime(_ number: (Int, Int)) -> String? {
        let (hour, minute) = number
        if minute < 10{
            return "\(hour):0\(minute)"
        } else {
            return "\(hour):\(minute)"
        }
    }
    
    func resetNumbers() {
        time = "0:00"
        numbers = []
    }
    
    
    func checkInput(_ input: String) -> Void {
        switch input {
        case "+", "-" :
            
            print(isFirstNumber)
            print(isShowingResult)
            print("")
            
            operation = input
            
            if isFirstNumber {
                firstNumber = arrayToInt(from: numbers)
                resetNumbers()
                isFirstNumber = false
                firstTime = intToTime(firstNumber)
            } else if isShowingResult {
                firstNumber = result
                firstTime = intToTime(firstNumber)
                resetNumbers()
                isShowingResult = false
            } else {
                secondNumber = arrayToInt(from: numbers)
                resetNumbers()
                calculate()
                firstNumber = result
                isShowingResult = true
            }
               
        case "=":
            print(isFirstNumber)
            print(isShowingResult)
            print("")
            
            if isFirstNumber{
                return
            } else if isShowingResult {
                resetNumbers()
                calculate()
                firstNumber = result
                isShowingResult = true
            } else {
                secondNumber = arrayToInt(from: numbers)
                resetNumbers()
                calculate()
                firstNumber = result
                isShowingResult = true
            }
            
        case "AC":
            print(isFirstNumber)
            print(isShowingResult)
            print("")
            
            resetTime()
            print("C button pressed, status: \((numbers, firstNumber, secondNumber, operation))")
        case "C":
            
            if numbers.count != 0 {
                numbers = []
                renderNumbers()
            }
            if numbers.isEmpty {
                delToAc()
                renderNumbers()
            }
            print("C button pressed, status: \((numbers, firstNumber, secondNumber, operation))")
        case "Del":
            if isShowingResult {
                return
            }
            if numbers.count != 0 {
                numbers.removeLast()
                renderNumbers()
            }
            if numbers.isEmpty {
                delToAc()
            }
        default:
            print(isFirstNumber)
            print(isShowingResult)
            print("")
            acToDel()
            
            isShowingResult = false
            if isFirstNumber {
                if numbers.count < 8 {
                    numbers.append(input)
                }
                renderNumbers()
            } else if isShowingResult {
                if numbers.count < 8 {
                    numbers.append(input)
                }
                renderNumbers()
            } else {
                if numbers.count < 8 {
                    numbers.append(input)
                }
                renderNumbers()
            }
            
            
            
            
            
//            if isFirstNumber {
//                firstNumber = (0, 0)
//                secondNumber = (0, 0)
//            }
//            if numbers.count < 8 {
//                numbers.append(input)
//            }
//            renderNumbers()
//            isShowingResult = false
        }
    }
    
    func resetTime() {
        time = "0:00"
        firstNumber = (0, 0)
        secondNumber = (0, 0)
        isFirstNumber = true
        isShowingResult = false
        numbers = []
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
            let (firstHour, firstMinute) = firstNumber
            let (secondHour, secondMinute) = secondNumber
            let totals = firstMinute + secondMinute
            if totals >= 60{
                result = ((firstHour + secondHour + 1), ((firstMinute + secondMinute) % 60))
            } else {
                result = ((firstHour + secondHour), (firstMinute + secondMinute))
            }
            let timeOne = intToTime(firstNumber)
            let timeTwo = intToTime(secondNumber)
            let resultTime = intToTime(result)
            if timeOne != nil && timeTwo != nil && resultTime != nil {
                let calc = Calculation(firstTime: timeOne!, secondTime: timeTwo!, operation: "+", result: resultTime!)
                calculations.append(calc)
                time = calc.result
            }
            
        } else if operation == "-" {
            let (firstHour, firstMinute) = firstNumber
            let (secondHour, secondMinute) = secondNumber
            let totalMinutes = firstMinute - secondMinute
            let totalHours = firstHour - secondHour
            print(totalHours)
            print(totalMinutes)
            if (totalMinutes < 0 && totalHours < 1) || totalHours < 0 {
                time = "Error"
                return
            } else if totalMinutes < 0 && totalHours >= 1 {
                result = ((firstHour - secondHour - 1), (60 + (firstMinute - secondMinute)))
            } else {
                result = ((firstHour - secondHour), (firstMinute - secondMinute))
            }
            let timeOne = intToTime(firstNumber)
            let timeTwo = intToTime(secondNumber)
            let resultTime = intToTime(result)
            if timeOne != nil && timeTwo != nil && resultTime != nil {
                let calc = Calculation(firstTime: timeOne!, secondTime: timeTwo!, operation: "-", result: resultTime!)
                calculations.append(calc)
                time = calc.result
            }
        } else {
            return
        }
    }
    
    
}
