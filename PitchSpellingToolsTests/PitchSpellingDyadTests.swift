//
//  PitchSpellingDyadTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import XCTest
@testable import PitchSpellingTools

class PitchSpellingDyadTests: XCTestCase {
    
    func testTwoCMeanSharpnessZero() {
        let dyad = PitchSpellingDyad(PitchSpelling(.C), PitchSpelling(.C))
        XCTAssertEqual(dyad.meanSharpness, 0)
    }
}
