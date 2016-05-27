//
//  PredicatesTests.swift
//  ArrayTools
//
//  Created by James Bean on 5/27/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArrayTools

class PredicatesTests: XCTestCase {
    
    func testPredicatesTrue() {
        let array = [1,1,1,1,1,1,1,1]
        XCTAssertTrue(array.allMatch { $0 == 1 })
    }
    
    func testPredicatesFalse() {
        let array = [1,2,3,4,5,6,7,8,9]
        XCTAssertFalse(array.allMatch { $0 == 1})
    }
}
