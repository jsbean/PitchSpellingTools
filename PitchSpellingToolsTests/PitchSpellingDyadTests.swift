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
    
    func testTwoCMeanDistanceZero() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.c))
        XCTAssertEqual(dyad.meanDistance, 0)
    }
    
    func testIntervalQualityTwoCsUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQualityKind.PerfectUnison)
    }
    
    func testCGPerfectFifth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.g))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Fifth.Perfect)
    }
    
    func testGCPerfectFourth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Fourth.Perfect)
    }
    
    func testCEMajorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Third.Major)
    }
    
    func testCEFlatMinorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Third.Minor)
    }
    
    func testCSharpEFlatDiminishedThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c, .sharp), PitchSpelling(.e, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Third.Diminished)
    }
    
    func testBbDSharpAugmentedThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.d, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Third.Augmented)
    }
    
    func testBbCSharpAugmentedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.c, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Second.Augmented)
    }
    
    func testCCFlatDiminishedUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.c, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Unison.Diminished)
    }
    
    func testCFlatCAugmentedUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c, .flat), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Unison.Augmented)
    }
    
    func testCEStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e))
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testCEFlatStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e, .flat))
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testCDFlatStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.d, .flat))
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testGSharpBFlatNotStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g, .sharp), PitchSpelling(.b, .flat))
        XCTAssertFalse(dyad.isStepPreserving)
    }
    
    func testCSharpFNotStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c, .sharp), PitchSpelling(.f))
        XCTAssertFalse(dyad.isStepPreserving)
    }
    
    func testCQuarterSharpFQuarterSharpStepPreserviing() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .quarterSharp), PitchSpelling(.f, .quarterSharp)
        )
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testCQuarterSharpFSharpStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .quarterSharp), PitchSpelling(.f, .sharp)
        )
        XCTAssertTrue(dyad.isStepPreserving)
    }
}
