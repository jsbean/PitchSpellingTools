//
//  ComparableTests.swift
//  EnumTools
//
//  Created by James Bean on 5/11/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import EnumTools

enum A: Int, Comparable {
    case a = 1
    case b = 9
    case c = 4
}

class ComparableTests: XCTestCase {
    
    func testComparison() {
        XCTAssertTrue(A.a < A.b)
        XCTAssertTrue(A.b > A.a)
        XCTAssertTrue(A.b > A.c)
        XCTAssertTrue(A.c < A.b)
    }
}
