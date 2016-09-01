//
//  EquatableTests.swift
//  ArrayTools
//
//  Created by James Bean on 4/27/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArrayTools

class EquatableTests: XCTestCase {

    func testIsHomogeneousEmptyNil() {
        let array: [Int] = []
        XCTAssertNil(array.isHomogeneous)
    }
    
    func testIsHomogeneousSingleElementNil() {
        let array: [Int] = [0]
        XCTAssertNil(array.isHomogeneous)
    }
    
    func testIsHeterogeneousEmptyNil() {
        let array: [Int] = []
        XCTAssertNil(array.isHeterogeneous)
    }
    
    func testIsHeterogeneousSingleElementNil() {
        let array: [Int] = [0]
        XCTAssertNil(array.isHeterogeneous)
    }
    
    func testIsHomoegeneous() {
        XCTAssert([1,1,1,1,1].isHomogeneous!)
    }
    
    func testIsHomogeneousFail() {
        XCTAssertFalse([1,2,1,1].isHomogeneous!)
    }
    
    func testIsHeterogeneousFalse() {
        XCTAssertFalse([1,1,1,1,1].isHeterogeneous!)
    }
}
