//
//  IntervalQualityTests.swift
//  Pitch
//
//  Created by James Bean on 4/30/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import EnumTools
@testable import PitchSpellingTools

class IntervalQualityTests: XCTestCase {

    let c = SpelledPitch(60, PitchSpelling(.c))
    let d_double_flat = SpelledPitch(60, PitchSpelling(.d, .doubleFlat))
    let c_sharp = SpelledPitch(61, PitchSpelling(.c, .sharp))
    let d = SpelledPitch(62, PitchSpelling(.d))
    let e_flat = SpelledPitch(63, PitchSpelling(.e, .flat))
    let fsharp = SpelledPitch(66, PitchSpelling(.f, .sharp))
    let bflat = SpelledPitch(70, PitchSpelling(.b, .flat))
    let g = SpelledPitch(67, PitchSpelling(.g))
    
    func testIntervalQuality() {
        let m3 = IntervalQuality.third.minor
        XCTAssert(IntervalQuality.third.has(m3))
    }
    
    func testAugmentedFourthStepPreserving() {
        let A4 = IntervalQuality.fourth.augmented
        XCTAssertTrue(A4.hasValidIntervalQuality)
    }

    func testClassifyIntervalUnison() {
        let kind = SpelledDyad(c,c).intervalQuality
        XCTAssertEqual(kind, IntervalQuality.unison.perfect)
    }

    func testClassifyIntervalSecond() {
        let kind = SpelledDyad(c, d).intervalQuality
        XCTAssertEqual(kind, IntervalQuality.second.major)
    }

    func testClassifyIntervalMinorThird() {
        let kind = SpelledDyad(c, e_flat).intervalQuality
        XCTAssertEqual(kind, IntervalQuality.third.minor)
    }
    
    func testClassifyIntervalFifth() {
        let kind = SpelledDyad(c, g).intervalQuality
        XCTAssertEqual(kind, IntervalQuality.fifth.perfect)
    }
    
    func testDiminishedFourth() {
        let kind = SpelledDyad(fsharp, bflat).intervalQuality
        XCTAssertEqual(kind, IntervalQuality.fourth.diminished)
    }
    
//    func testDiminishedSecond() {
//        let kind = classifyInterval(c, d_double_flat)
//        XCTAssertEqual(kind, IntervalQuality.second.diminished)
//    }
    
    func testDoubleDiminishedSecond() {
        let kind = SpelledDyad(c_sharp, d_double_flat).intervalQuality
        XCTAssertEqual(kind, IntervalQuality.second.doubleDiminished)
    }
}

