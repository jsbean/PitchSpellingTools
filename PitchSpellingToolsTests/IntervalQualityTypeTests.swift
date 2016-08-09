//
//  IntervalQualityTypeTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/8/16.
//
//

import XCTest
@testable import PitchSpellingTools

class IntervalQualityTypeTests: XCTestCase {

    // - note: 0: perfect, 0.5: major, -0.5: minor, > 0.5: augmented, < -0.5: diminished
    
    func testPerfectUnisonIntervalQualityType() {
        XCTAssertEqual(
            IntervalQuality.unison._kind(intervalClass: 0),
            IntervalQuality.unison.perfect
        )
    }
    
    func testMajorSecondIntervalQualityType() {
        XCTAssertEqual(
            IntervalQuality.second._kind(intervalClass: 0.5),
            IntervalQuality.second.major
        )
    }
    
    func testAugmentedFifth() {
        XCTAssertEqual(
            IntervalQuality.fifth._kind(intervalClass: 1),
            IntervalQuality.fifth.augmented
        )
    }
}
