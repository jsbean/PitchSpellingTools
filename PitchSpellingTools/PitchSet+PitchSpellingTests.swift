//
//  PitchSet+PitchSpellingTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/19/17.
//
//

import XCTest
import Pitch
import PitchSpellingTools

class PitchSet_PitchSpellingTests: XCTestCase {
    
    func testEmptyEmpty() {
        let pitchSet: PitchSet = []
        XCTAssertEqual(pitchSet.spelledWithDefaultSpelling(), [])
    }
    
    func testMiddleC() {
        let pitchSet: PitchSet = [60]
        XCTAssertEqual(
            pitchSet.spelledWithDefaultSpelling(),
            [SpelledPitch(60, PitchSpelling(.c))]
        )
    }
    
    func testPitchSet() {
        let pitchSet: PitchSet = [60, 61, 70]
        XCTAssertEqual(
            pitchSet.spelledWithDefaultSpelling(),
            [
                SpelledPitch(60, PitchSpelling(.c)),
                SpelledPitch(61, PitchSpelling(.c, .sharp)),
                SpelledPitch(70, PitchSpelling(.b, .flat))
            ]
        )
    }
}
