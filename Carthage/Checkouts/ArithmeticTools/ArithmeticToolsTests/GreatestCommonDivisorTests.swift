//
//  GreatestCommonDivisorTests.swift
//  ArithmeticTools
//
//  Created by James Bean on 2/18/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArithmeticTools

class GreatestCommonDivisorTests: XCTestCase {
    
    func testIntALessThanB() {
        let a: Int = 8
        let b: Int = 12
        let greatestCommonDivisor = gcd(a,b)
        XCTAssertEqual(greatestCommonDivisor, 4)
    }
    
    func testIntAGreaterThanB() {
        let a: Int = 12
        let b: Int = 8
        let greatestCommonDivisor = gcd(a,b)
        XCTAssertEqual(greatestCommonDivisor, 4)
    }
}
