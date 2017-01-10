//
//  PrimeTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/18/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class PrimeTests: XCTestCase {
    
    func testIntIsPrimeTrue() {
        XCTAssertTrue(5.isPrime)
        XCTAssertTrue(727.isPrime)
        XCTAssertTrue(24611.isPrime)
    }
    
    func testIntIsPrimeFalse() {
        XCTAssertFalse(4.isPrime)
        XCTAssertFalse(9.isPrime)
        XCTAssertFalse(10000.isPrime)
    }
    
    func testIntIsPrime1IsFalse() {
        XCTAssertFalse(1.isPrime)
    }
    
    func testIntIsPrime0IsFalse() {
        XCTAssertFalse(0.isPrime)
    }
    
    func testIntIsPrimeNegativeIsFalse() {
        XCTAssertFalse((-1).isPrime)
        XCTAssertFalse((-3).isPrime)
        XCTAssertFalse((-9).isPrime)
    }
    
    func testIntIsPrime2IsTrue() {
        XCTAssertTrue(2.isPrime)
    }
    
    func testIntIsPrime3IsTrue() {
        XCTAssertTrue(3.isPrime)
    }
}
