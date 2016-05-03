//
//  PitchSpellingDyadTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import XCTest
import EnumTools
@testable import PitchSpellingTools

class PitchSpellingDyadTests: XCTestCase {
    
    func testTwoCMeanSharpnessZero() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.c))
        XCTAssertEqual(dyad.meanSharpness, 0)
    }
    
    func testIntervalQualityTwoCsUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQualityKind.PerfectUnison)
    }
    
    func testIntervalQuality() {
        for letterNameLower in PitchSpelling.LetterName.allCases {
            for letterNameHigher in PitchSpelling.LetterName.allCases {
                let dyad = PitchSpellingDyad(
                    PitchSpelling(letterNameLower),
                    PitchSpelling(letterNameHigher)
                )
                print("\(dyad): \(dyad.intervalQuality)")
            }
        }
    }
}
