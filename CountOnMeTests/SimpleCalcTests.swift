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
    // MARK: Functions for tests
    func numberAddedToTest(_ number: String) {
        simpleCalc.calculatorText = simpleCalc.addNumber(number)
    }

    func operatorAddedToTest(_ operand: SimpleCalc.Operators) {
        simpleCalc.calculatorText = simpleCalc.addOperator(operand)
    }
    func calculateOperationTest() {
        simpleCalc.calculatorText = simpleCalc.calculate()
    }
    // MARK: Test Operations
    func testGivenCalculIs3x2_WhenCalculate_ThenTotalIs6() { // Check simple multiplication
        numberAddedToTest("3")
        operatorAddedToTest(.multiplication)
        numberAddedToTest("2")
        calculateOperationTest()

        XCTAssertEqual(simpleCalc.calculatorText, "3 x 2 = 6")
    }

    func testGivenCalculIs5DividedBy2_WWenCalculate_ThenTotalIs2Dot5() { // Check Division with a dot result
        numberAddedToTest("5")
        operatorAddedToTest(.division)
        numberAddedToTest("2")
        calculateOperationTest()
        XCTAssertEqual(simpleCalc.calculatorText, "5 / 2 = 2.5")
    }

    func testGivenCalculWithAllOperators_WhenCalculate_ThenXAndDivisionArePriorityOperators() {// Test priority calcul
        numberAddedToTest("25")
        operatorAddedToTest(.addition)
        numberAddedToTest("10")
        operatorAddedToTest(.multiplication)
        numberAddedToTest("2")
        operatorAddedToTest(.substraction)
        numberAddedToTest("32")
        operatorAddedToTest(.division)
        numberAddedToTest("2")
        calculateOperationTest()
        XCTAssertEqual(simpleCalc.calculatorText, "25 + 10 x 2 - 32 / 2 = 29")
    }

    func testGiven2Plus1AndCalculate_WhenTapped3_ThenTextIs3() { // Check if pass to new operation after total
        numberAddedToTest("2")
        operatorAddedToTest(.addition)
        numberAddedToTest("1")
        calculateOperationTest()
        numberAddedToTest("3")
        XCTAssertEqual(simpleCalc.calculatorText, "3")
    }
    // MARK: Operators errors

    func testGivenOperationIsOnePlus_WhenAddx_ThenNoTextChange() {
        numberAddedToTest("1")
        operatorAddedToTest(.addition)

        operatorAddedToTest(.multiplication)
        operatorAddedToTest(.division)
        operatorAddedToTest(.addition)
        operatorAddedToTest(.substraction)
        XCTAssertEqual(simpleCalc.calculatorText, "1 + ")
    }

    func testGivenWrongOperation_WhenCalculateTotal_ThenTextIsReset() { //not possible but needed to be 100% tested
        simpleCalc.calculatorText = " + 1 + 1"

        calculateOperationTest()

        XCTAssertEqual(simpleCalc.calculatorText, "")
    }

    func testGivenNoNumber_WhenAddOperator_ThenTextIs0() {
        operatorAddedToTest(.addition)

        XCTAssertEqual(simpleCalc.calculatorText, "0")
    }
    // MARK: Calculs errors
    func testGivenOperationIsOnePlus_WhenCalculate_ThenNoTextChange() {
        numberAddedToTest("1")
        operatorAddedToTest(.addition)
        calculateOperationTest()
        XCTAssertEqual(simpleCalc.calculatorText, "1 + ")
    }

    func testGiven6DivisionZero_WhenCalculate_ThenTextIsReset() { // Debug Division by zero
        numberAddedToTest("6")
        operatorAddedToTest(.division)
        numberAddedToTest("0")

        calculateOperationTest()

        XCTAssertEqual(simpleCalc.calculatorText, "0")
    }

    func testGivenNoOperation_WhenCalculate_ThenNoTextChange() {  // Debug when is empty
        calculateOperationTest()

        XCTAssertEqual(simpleCalc.calculatorText, "0")
    }

    func testGivenOneAndNoOPerator_WhenCalculate_ThenTextIsReset() {
        numberAddedToTest("1")

        calculateOperationTest()

        XCTAssertEqual(simpleCalc.calculatorText, "0")
    }
    func testGivenComplexOperationWithBigNumbers_WhenCalculate_ThenResultHasReplacedComa() {
        numberAddedToTest("875")
        operatorAddedToTest(.multiplication)
        numberAddedToTest("56")
        operatorAddedToTest(.substraction)
        numberAddedToTest("12")
        calculateOperationTest()
        XCTAssertEqual(simpleCalc.calculatorText, "875 x 56 - 12 = 48988")
    }

    func testGivenCalculIs2Plus1_WhenTappedTwiceEqual_ThenTextIs0() {
        numberAddedToTest("2")
        operatorAddedToTest(.addition)
        numberAddedToTest("1")

        calculateOperationTest()
        calculateOperationTest()

        XCTAssertEqual(simpleCalc.calculatorText, "0")
    }

    // MARK: Clear Tests
    func testGiven1Plus2_WhenClearLastAction_ThenTextIs1Plus() {
        numberAddedToTest("1")
        operatorAddedToTest(.addition)
        numberAddedToTest("2")
        _ = simpleCalc.clearLastAction()

        XCTAssertEqual(simpleCalc.calculatorText, "1 + ")
    }

    func testGiven1Plus_WhenClearLastAction_ThenTextIs1() {
        numberAddedToTest("1")
        operatorAddedToTest(.addition)

        _ = simpleCalc.clearLastAction()

        XCTAssertEqual(simpleCalc.calculatorText, "1")
    }
    func testGivenElementsArrayIsEmpty_WhenClearLastAction_ThenTextIsCleared() {

        _ = simpleCalc.clearLastAction()
        _ = simpleCalc.clearLastAction()

        XCTAssertEqual(simpleCalc.calculatorText, "")
    }
    func testGivenComplexOperation_WhenClearOperations_ThenTextIsCleared() {
        numberAddedToTest("875")
        operatorAddedToTest(.multiplication)
        numberAddedToTest("56")
        operatorAddedToTest(.substraction)
        numberAddedToTest("12")
        _ = simpleCalc.clearOperations()
        XCTAssertEqual(simpleCalc.calculatorText, "0")
    }
}
