//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var equalButton: UIButton!

    let simpleCalc = SimpleCalc()

    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }

    var expressionHaveResultOr0: Bool {
        return textView.text.firstIndex(of: "=") != nil || textView.text == "0"
    }

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func allClear() {
        textView.text.removeAll()
        textView.text = "0"
        equalButton.isEnabled = true
    }

    fileprivate func errorAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        equalButton.isEnabled = true
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResultOr0 {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    @IBAction func tappedDotButton(_ sender: UIButton) {
        guard let dotNumber = sender.title(for: .normal) else { return }
        if simpleCalc.canAddDot(elements) {
            textView.text.append(dotNumber)
        } else {
            errorAlert("Vous ne pouvez pas rajouter de virgule")
        }
    }

    @IBAction func tappedClearButton(_ sender: UIButton) {
        allClear()
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if simpleCalc.canAddOperator(elements) {
            textView.text.append(" + ")
        } else {
            errorAlert("Un operateur est déja mis !")
        }
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if simpleCalc.canAddOperator(elements) {
            textView.text.append(" - ")
        } else {
            errorAlert("Un operateur est déja mis !")
        }
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if simpleCalc.canAddOperator(elements) {
            textView.text.append(" / ")
        } else {
            errorAlert("Un operateur est déja mis !")
        }
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if simpleCalc.canAddOperator(elements) {
            textView.text.append(" x ")
        } else {
            errorAlert("Un operateur est déja mis !")
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard simpleCalc.expressionHaveEnoughElement(elements) else {
            return errorAlert("Entrez une expression correcte !")
        }

        if let result = simpleCalc.reduceOperation(elements) {
            textView.text.append(" = \(result)")
            sender.isEnabled = false
        }
    }
}
