//
//  RelativeDirectionTests.swift
//  DirectionTools
//
//  Created by James Bean on 3/1/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import DirectionTools

class RelativeDirectionTests: XCTestCase {

    func testX() {
        XCTAssert(RelativeDirection.X.has(.Left))
        XCTAssert(RelativeDirection.X.has(.Right))
        XCTAssertFalse(RelativeDirection.X.has(.Up))
        XCTAssertFalse(RelativeDirection.X.has(.Forwards))
    }
    
    func testY() {
        XCTAssert(RelativeDirection.Y.has(.Up))
        XCTAssert(RelativeDirection.Y.has(.Down))
        XCTAssertFalse(RelativeDirection.Y.has(.Left))
        XCTAssertFalse(RelativeDirection.Y.has(.Backwards))
    }
    
    func testZ() {
        XCTAssert(RelativeDirection.Z.has(.Forwards))
        XCTAssert(RelativeDirection.Z.has(.Backwards))
        XCTAssertFalse(RelativeDirection.Z.has(.Right))
        XCTAssertFalse(RelativeDirection.Z.has(.Up))
    }
}