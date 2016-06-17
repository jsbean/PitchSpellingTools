//
//  CopyableTests.swift
//  CopyTools
//
//  Created by James Bean on 3/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import CopyTools

class CopyableTests: XCTestCase {
    
    func testCopy() {
        let tc1 = TestClass(value: 42)
        let tc2 = TestClass(copy: tc1)
        XCTAssert(tc1 == tc2)
        XCTAssert(tc1 !== tc2)
    }
    
    func testRecursiveCopy() {
        let trc1 = TestRecursiveClass(
            value: 1,
            parent: TestRecursiveClass(value: 0),
            children: [TestRecursiveClass(value: 2)]
        )
        let trc2 = TestRecursiveClass(copy: trc1)
        XCTAssert(trc1 == trc2)
        XCTAssert(trc1 !== trc2)
    }
}