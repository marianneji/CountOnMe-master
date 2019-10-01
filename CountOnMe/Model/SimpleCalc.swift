//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Graphic Influence on 13/09/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol DisplayAlert: class {
    func errorAlert(_ message: String)
}

class SimpleCalc {

    weak var displayAlertDelegate: DisplayAlert?
    var calculatorText = "0"
    var result = Double()

    enum Operators: String {
        case addition = "+"
        case substraction = "-"
        case multiplication = "x"
        case division = "/"
    }

    var elements: [String] {
        return calculatorText.split(separator: " ").map { "\($0)" }
    }

    // MARK: Error Checks
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    private var removeOperator: Bool {
        return
            calculatorText.last == "+" ||
                calculatorText.last == "-" ||
                calculatorText.last == "x" ||
                calculatorText.last == "/"
    }

    private var expressionHaveResult: Bool {
        return calculatorText.firstIndex(of: "=") != nil || calculatorText == "0"
    }

    func addNumber(_ numberText: String) -> String {
        if expressionHaveResult {
            calculatorText = ""
        }
        calculatorText.append(numberText)
        return calculatorText
    }

    func addOperator(_ operand: Operators) -> String {
        if expressionHaveResult {
            displayAlertDelegate?.errorAlert("Rentrez un chiffre pour démarrer votre calcul")
            calculatorText = "0"
            return calculatorText
        }
        if canAddOperator {
            calculatorText.append(" " + operand.rawValue + " ")
        } else {
            displayAlertDelegate?.errorAlert("Un operateur est déja mis !")
        }
        return calculatorText
    }

    fileprivate func removeUseless0() -> Bool {
        for element in elements where element.first == "0" {
                calculatorText = calculatorText.replacingOccurrences(of: "0", with: "")
        }
        return true
    }

    fileprivate func convertForResult(_ operationsToReduce: inout [String], _ operationIndex: Int) {
        operationsToReduce.remove(at: operationIndex + 1)
        operationsToReduce.remove(at: operationIndex)
        operationsToReduce.remove(at: operationIndex - 1)
        operationsToReduce.insert("\(removeDotZero(result))", at: operationIndex - 1)
    }

    fileprivate func reduceOperation() -> String {
        var operationsToReduce = elements

        while operationsToReduce.count > 1 {

            var operationIndex = Int()
            if let priorityOperator = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "/"}) {
                operationIndex = priorityOperator
            } else {
                operationIndex = 1
            }
            let operand = operationsToReduce[operationIndex]
            guard let left = Double(operationsToReduce[operationIndex - 1]),
                let right = Double(operationsToReduce[operationIndex + 1]) else { calculatorText = ""
                    displayAlertDelegate?.errorAlert("Erreur inconnue !") // due of stability
                    return calculatorText
            }
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            if right == 0 {
                displayAlertDelegate?.errorAlert("Division par 0 impossible")
                calculatorText = "0"
                return calculatorText
                }
            default: displayAlertDelegate?.errorAlert("Démarrez un nouveau calcul")
            calculatorText = "0"
            return calculatorText
            }
            convertForResult(&operationsToReduce, operationIndex)
        }
        if let returnValue = operationsToReduce.first {
            calculatorText.append(" = \(returnValue)")
        }
        return calculatorText
    }

    func calculate() -> String {

        guard canAddOperator else {
            displayAlertDelegate?.errorAlert("Un opérateur est déjà mis")
            return calculatorText
        }
        guard expressionHaveEnoughElement else {
            displayAlertDelegate?.errorAlert("Il manque des éléments pour le calcul")
            return calculatorText
        }
        guard removeUseless0() else {
            return calculatorText
        }

        return reduceOperation()
    }
    // remove dot and coma to display a number
    private func removeDotZero(_ result: Double) -> String {
        var doubleAsString = NumberFormatter.localizedString(from: (NSNumber(value: result)), number: .decimal)
        if doubleAsString.contains(",") {
            doubleAsString = doubleAsString.replacingOccurrences(of: ",", with: "")
        }
        return doubleAsString
    }

    func clearOperations() -> String {
        calculatorText = "0"
        return calculatorText

    }

    func clearLastAction() -> String {
        if !calculatorText.isEmpty {
            calculatorText.removeLast()
            if removeOperator {
                calculatorText = String(calculatorText.dropLast(2))
            }
        } else {
            calculatorText = ""
        }
        return calculatorText
    }
}
