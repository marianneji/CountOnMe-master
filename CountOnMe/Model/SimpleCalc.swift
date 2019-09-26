//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Graphic Influence on 13/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct SimpleCalc {

    // MARK: Error Checks
    func expressionHaveEnoughElement(_ elements: [String]) -> Bool {
        return elements.count >= 3
    }

    func canAddOperator(_ elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }

    func canAddDot(_ elements: [String]) -> Bool {
        if let lastElement = elements.last { return Double(lastElement) != nil }
        return false
    }

    // Iterate over operations while an operand still here
    func reduceOperation(_ elements: [String]) -> String? {
        var operationsToReduce = elements
        var result: Double

        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!

            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            if right == 0 {
                return "Erreur"
                }
            default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(removeDotZero(result: result))", at: 0)
        }
        return operationsToReduce.first!
    }
    // remove dot and zero to display an integer
    private func removeDotZero(result: Double) -> String {
        let doubleAsString = NumberFormatter.localizedString(from: (NSNumber(value: result)), number: .decimal)
        return doubleAsString
    }
}
