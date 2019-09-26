//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    var simpleCalc: SimpleCalc!

    override func setUp() {
        super.setUp()
        simpleCalc = SimpleCalc()
    }

    func testAdditionElementsExpectedResultEqual() {
        let elements = ["2", "+", "3"]
        let expected = "5"

        let result = simpleCalc.reduceOperation(elements)

        XCTAssertEqual(result, expected)
    }
    func testSoustractionElementsExpectedResultEqual() {
        let elements = ["3", "-", "2"]
        let expected = "1"

        let result = simpleCalc.reduceOperation(elements)

        XCTAssertEqual(result, expected)
    }
    func testMultiplicationElementsExpectedResultEqual() {
        let elements = ["2", "x", "3"]
        let expected = "6"

        let result = simpleCalc.reduceOperation(elements)

        XCTAssertEqual(result, expected)
    }
    func testDivisionBy0ElementsExpectedResultEqualErreur() {
        let elements = ["2", "/", "0"]
        let expected = "Erreur"

        let result = simpleCalc.reduceOperation(elements)

        XCTAssertEqual(result, expected)
    }
}
