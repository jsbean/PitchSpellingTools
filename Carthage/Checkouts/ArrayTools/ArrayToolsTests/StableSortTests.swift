//
//  StableSortTests.swift
//  ArrayTools
//
//  Created by James Bean on 6/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArrayTools

class StableSortTests: XCTestCase {

    func testStableSort() {
        var pairs = [(1,2),(1,3),(2,3),(2,5),(4,3),(3,2),(5,1)]
        pairs = pairs.stableSort { $0.0 < $1.0 }
        let firsts = pairs.map { $0.0 }
        let seconds = pairs.map { $0.1 }
        XCTAssertEqual(firsts, [1,1,2,2,3,4,5])
        XCTAssertEqual(seconds, [2,3,3,5,2,3,1])
    }
}
