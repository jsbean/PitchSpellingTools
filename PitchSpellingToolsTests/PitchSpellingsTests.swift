//
//  PitchSpellingsTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchSpellingsTests: XCTestCase {

    func testDefaultPitchSpellingsForEighthToneResolution() {
        stride(from: Float(0), to: 12.0, by: 0.25).forEach {
            XCTAssertNotNil(
                PitchSpellings.defaultSpelling(forPitchClass: PitchClass(floatLiteral: $0))
            )
        }
    }
    
    func testMiddleCPitchSpelling() {
        XCTAssertEqual(
            PitchSpellings.defaultSpelling(forPitchClass: Pitch.middleC.pitchClass)!,
            PitchSpelling(.c)
        )
    }
}
