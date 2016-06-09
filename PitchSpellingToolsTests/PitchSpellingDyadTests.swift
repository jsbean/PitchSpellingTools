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
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testCEFlatStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.e, .flat))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testCDFlatStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.d, .flat))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testGSharpBFlatNotStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g, .sharp), PitchSpelling(.b, .flat))
        XCTAssertFalse(dyad.hasValidIntervalQuality)
    }
    
    func testCSharpFNotStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c, .sharp), PitchSpelling(.f))
        XCTAssertFalse(dyad.hasValidIntervalQuality)
    }
    
    func testCQuarterSharpFQuarterSharpStepPreserviing() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .quarterSharp), PitchSpelling(.f, .quarterSharp)
        )
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testCQuarterSharpFSharpStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .quarterSharp),
            PitchSpelling(.f, .sharp)
        )
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testEFlatBQuarterFlatStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.e, .flat),
            PitchSpelling(.b, .quarterFlat)
        )
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testCQuarterSharpGQuarterFlatNotStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .quarterSharp),
            PitchSpelling(.g, .quarterFlat)
        )
        XCTAssertFalse(dyad.hasValidIntervalQuality)
    }
    
    func testCSharpGFlatDoubleDiminishedFifth() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .sharp),
            PitchSpelling(.g, .flat)
        )
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.fifth.doubleDiminished)
    }
    
    func testCQuarterSharpFThreeQuarterSharpStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.c, .quarterSharp),
            PitchSpelling(.f, .threeQuarterSharp))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testBFSharpStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.f, .sharp))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testBNaturalFThreeQuarterSharpStepPreserving() {
        let dyad = PitchSpellingDyad(
            PitchSpelling(.b, .natural),
            PitchSpelling(.f, .threeQuarterSharp)
        )
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testFBFlatStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.f), PitchSpelling(.b, .flat))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testBCStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.c))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
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
    
    func testAGFlatDiminishedSeventh() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a), PitchSpelling(.g, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.seventh.diminished)
    }
    
    func testAFSharpMajorSixth() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a), PitchSpelling(.f, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.sixth.major)
    }
    
    func testACSharpMajorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a), PitchSpelling(.c, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.third.major)
    }
    
    func testDFSharpMajorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.d), PitchSpelling(.f, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.third.major)
    }
    
    func testEGSharpMajorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.e), PitchSpelling(.g, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.third.major)
    }
    
    func testBDSharpMajorThird() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b), PitchSpelling(.d, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.third.major)
    }
    
    func testAGFlatNotStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a), PitchSpelling(.g, .flat))
        XCTAssertFalse(dyad.hasValidIntervalQuality)
    }
    
    func testAFSharpStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a), PitchSpelling(.f, .sharp))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testCFSharpStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.f, .sharp))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testCGFlatStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.g, .flat))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testBFlatEStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.e))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testASharpEStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a, .sharp), PitchSpelling(.e))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testGGFlatNotStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.g, .flat))
        XCTAssertFalse(dyad.hasValidIntervalQuality)
    }
    
    func testGAFlatMinorSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.a, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.minor)
    }
    
    func testDCSharpMajorSeventh() {
        let dyad = PitchSpellingDyad(PitchSpelling(.d), PitchSpelling(.c, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.seventh.major)
    }
    
    func testCBMajorSeventh() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.b))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.seventh.major)
    }
    
    func testGFSharpMajorSeventh() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.f, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.seventh.major)
    }
    
    func testGFSharpStepPreserving() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.f, .sharp))
        XCTAssertTrue(dyad.hasValidIntervalQuality)
    }
    
    func testAGSharpMajorSeventh() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a), PitchSpelling(.g, .sharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.seventh.major)
    }
    
    func testBFlatAMajorSeventh() {
        let dyad = PitchSpellingDyad(PitchSpelling(.b, .flat), PitchSpelling(.a))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.seventh.major)
    }
    
    func testFSharpEDoubleSharpMajorSeventh() {
        let dyad = PitchSpellingDyad(PitchSpelling(.f, .sharp), PitchSpelling(.e, .doubleSharp))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.seventh.major)
    }
    
    func testABFlatMinorSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.a), PitchSpelling(.b, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.minor)
    }
    
    func testDEFlatMinorSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.d), PitchSpelling(.e, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.minor)
    }
    
    func testCDFlatMinorSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.d, .flat))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.minor)
    }
    
    func testCDMajorSecond() {
        let dyad = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.d))
        XCTAssertEqual(dyad.intervalQuality, IntervalQuality.second.major)
    }
    
    func testIsFineCompatibleNoFineAdjustmentTrue() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.a))
        XCTAssertTrue(dyad.isFineCompatible)
    }
    
    func testIsFineCompatibleSameLetterNameFalse() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.g, .natural, .down))
        XCTAssertFalse(dyad.isFineCompatible)
    }
    
    func testOneNaturalTheOtherQuarterTone() {
        let dyad = PitchSpellingDyad(PitchSpelling(.g), PitchSpelling(.a, .quarterSharp, .up))
        XCTAssert(dyad.isFineCompatible)
    }
}

