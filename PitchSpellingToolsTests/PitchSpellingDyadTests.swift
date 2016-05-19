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
        XCTAssertEqual(dyad.meanSpellingDistance, 0)
    }
    
    func testIntervalQualityTwoCsUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQualityKind.perfectUnison)
    }
    
    func testCGperfectFifth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.g))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fifth.perfect)
    }
    
    func testGCperfectFourth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fourth.perfect)
    }
    
    func testCEmajorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.third.major)
    }
    
    func testCEFlatminorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.third.minor)
    }
    
    func testCSharpEFlatdiminishedThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c, .sharp), PitchSpelling(.e, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.third.diminished)
    }
    
    func testBbDSharpaugmentedThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.d, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.third.augmented)
    }
    
    func testBbCSharpAugmentedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.c, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.augmented)
    }
    
    func testGASharpAugmentedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.a, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.augmented)
    }
    
    func testBCFlatDiminishedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.c, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.diminished)
    }
    
    func testEFlatDiminishedSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.e), PitchSpelling(.f, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.diminished)
    }
    
    func testCCFlatdiminishedUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.c, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.unison.diminished)
    }
    
    func testCFlatCaugmentedUnison() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c, .flat), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.unison.augmented)
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
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testFBFlatStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.f), PitchSpelling(.b, .flat))
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testBCStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.c))
        XCTAssertTrue(dyad.isStepPreserving)
    }
    
    func testBCIntervalQualityMinorSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.minor)
    }
    
    func testBGSharpMajorSixth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.g, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.sixth.major)
    }
    
    func testBGMinorSixth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.g))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.sixth.minor)
    }
    
    func testECMinorSixth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.e), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.sixth.minor)
    }
    
    func testECSharpMajorSixth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.e), PitchSpelling(.c, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.sixth.major)
    }
    
    func testCASharpAugmentedSixth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.a, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.sixth.augmented)
    }
    
    func testEFlatCSharpAugmentedSixth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.e, .flat), PitchSpelling(.c, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.sixth.augmented)
    }
    
    func testGESharpAugmentedSixth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.e, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.sixth.augmented)
    }
    
    func testBbEAugmentedFourth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.e))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fourth.augmented)
    }
    
    func testASharpEDiminishedFifth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a, .sharp), PitchSpelling(.e))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fifth.diminished)
    }
    
    func testFBAgumentedFourth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.f), PitchSpelling(.b))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fourth.augmented)
    }
    
    func testBFADimishedFifth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.f))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fifth.diminished)
    }
    
    func testFSharpCDiminishedFifth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.f, .sharp), PitchSpelling(.c))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fifth.diminished)
    }
    
    func testCFSharpAugmentedFourth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.f, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fourth.augmented)
    }
}
