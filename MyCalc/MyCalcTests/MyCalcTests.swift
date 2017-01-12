//
//  MyCalcTests.swift
//  MyCalcTests
//
//  Created by AdminAccount on 1/12/17.
//  Copyright © 2017 AdminAccount. All rights reserved.
//

import XCTest
@testable import MyCalc

class MyCalcTests: XCTestCase {
    
    var brain: CalculatorBrain? = nil
    
    override func setUp() {
        super.setUp()
        brain = CalculatorBrain()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        brain = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testsqrt9() {
        brain?.digit(value: 9)
        brain?.unary(operation: .Sqrt)
        var result: Double? = nil
        brain?.result = {(value, error) in
            result = value
        }
        brain?.utility(operation: .Equal)
        XCTAssert(result == 3)
    }
    
    func test2Plus3() {
        brain?.digit(value: 22.5)
        brain?.binary(operation: .Plus)
        brain?.digit(value: 3)
        var result: Double? = nil
        brain?.result = {(value, error) in
            result = value
        }
        brain?.utility(operation: .Equal)
        XCTAssert(result == 22.5)
    }

    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}