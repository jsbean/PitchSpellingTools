//
//  CombinationsTests.swift
//  ArrayTools
//
//  Created by James Bean on 5/5/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArrayTools

class CombinationsTests: XCTestCase {

    func testCombinations() {
        let array1 = [1,2,3]
        let array2 = [4,5]
        XCTAssertEqual(combinations(array1, array2).count, 6)
    }
}
