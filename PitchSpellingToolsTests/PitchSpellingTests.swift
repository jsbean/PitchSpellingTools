//
//  PitchSpellingTests.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchSpellingTests: XCTestCase {

    func testInitJustLetterName() {
        let ps = PitchSpelling(letterName: .F)
        XCTAssert(ps.coarse == .Natural)
        XCTAssert(ps.fine == .None)
    }
    
    func testCSharpnessIsZero() {
        XCTAssertEqual(PitchSpelling(.C).sharpness, 0)
    }
    
    func testBFlatSharpnessIsNegativeOne() {
        XCTAssertEqual(PitchSpelling(.B, .Flat).sharpness, -1)
    }
}
