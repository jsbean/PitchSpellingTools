//
//  PitchSpelling+StringLiteralConvertibleTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/17/16.
//
//

import XCTest
@testable import PitchSpellingTools

class PitchSpelling_StringLiteralConvertibleTests: XCTestCase {
    
    func testCNatural() {
        let ps: PitchSpelling = "c"
        XCTAssertEqual(ps, PitchSpelling(.c))
    }
    
    func testBNatural() {
        let ps: PitchSpelling = "b"
        XCTAssertEqual(ps, PitchSpelling(.b))
    }
}
