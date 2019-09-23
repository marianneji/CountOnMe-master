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
    func testGiven() {
        let inputs = ["2", "+", "3"]
        let expected = "5"

        let result = simpleCalc.reduceOperation(inputs)

        XCTAssertEqual(result, expected)
    }
}
