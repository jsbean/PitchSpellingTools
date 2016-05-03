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
        let ps = PitchSpelling(letterName: .f)
        XCTAssert(ps.coarse == .natural)
        XCTAssert(ps.fine == .none)
    }
    
    func testCSharpnessIsZero() {
        XCTAssertEqual(PitchSpelling(.c).sharpness, 0)
    }
    
    func testBFlatSharpnessIsNegativeOne() {
        XCTAssertEqual(PitchSpelling(.b, .flat).sharpness, -1)
    }
}
