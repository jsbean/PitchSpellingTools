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
        XCTAssertEqual(dyad.intervalQuality, IntervalQualityKind.perfectUnison)
    }
    
    func testCGperfectFifth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.g))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Fifth.perfect)
    }
    
    func testGCperfectFourth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Fourth.perfect)
    }
    
    func testCEmajorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Third.major)
    }
    
    func testCEFlatminorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Third.minor)
    }
    
    func testCSharpEFlatdiminishedThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c, .sharp), PitchSpelling(.e, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Third.diminished)
    }
    
    func testBbDSharpaugmentedThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.d, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Third.augmented)
    }
    
    func testBbCSharpAugmentedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.c, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Second.augmented)
    }
    
    func testGASharpAugmentedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.a, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Second.augmented)
    }
    
    func testBCFlatDiminishedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.c, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Second.diminished)
    }
    
    func testEFlatDiminishedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.e), PitchSpelling(.f, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Second.diminished)
    }
    
    func testCCFlatdiminishedUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.c, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Unison.diminished)
    }
    
    func testCFlatCaugmentedUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c, .flat), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.Unison.augmented)
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
            PitchSpelling(.c, .quarterSharp),
            PitchSpelling(.f, .sharp)
        )
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testEFlatBQuarterFlatStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.e, .flat),
            PitchSpelling(.b, .quarterFlat)
        )
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testCQuarterSharpGQuarterFlatNotStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .quarterSharp),
            PitchSpelling(.g, .quarterFlat))
        XCTAssertFalse(dyad.isStepPreserving)
    }
    
    func testCQuarterSharpFThreeQuarterSharpStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .quarterSharp),
            PitchSpelling(.f, .threeQuarterSharp))
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testBFSharpStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.f, .sharp))
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testBNaturalFThreeQuarterSharpStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.b, .natural),
            PitchSpelling(.f, .threeQuarterSharp)
        )
        print("interval quality: \(dyad.intervalQuality)")
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testFBFlatStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.f), PitchSpelling(.b, .flat))
        XCTAssertTrue(dyad.isStepPreserving)
    }
}
