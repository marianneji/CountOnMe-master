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
    @IBOutlet weak var clearButton: UIButton!

    let simpleCalc = SimpleCalc()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleCalc.displayAlertDelegate = self
    }

    @IBAction func tappedClearLast(_ sender: UIButton) {
        textView.text = simpleCalc.clearLastAction()
        print(simpleCalc.elements)

    }
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        textView.text = simpleCalc.addNumber(numberText)
        clearButton.isEnabled = true
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        textView.text = simpleCalc.addOperator(.addition)
        print(simpleCalc.elements)
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        textView.text = simpleCalc.addOperator(.substraction)
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        textView.text = simpleCalc.addOperator(.division)
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        textView.text = simpleCalc.addOperator(.multiplication)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        textView.text = simpleCalc.calculate()
        clearButton.isEnabled = false
        print(simpleCalc.elements)
    }

    @IBAction func tappedClearButton(_ sender: UIButton) {
        textView.text = simpleCalc.clearOperations()
        print(simpleCalc.elements)
    }
}

extension ViewController: DisplayAlert {
     func errorAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Erreur",
                                        message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK",
                                        style: .cancel,
                                        handler: nil))
        present(alertVC, animated: true)
    }
}
