//
//  RelativeNamedIntervalTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import PitchSpellingTools

class RelativeNamedIntervalTests: XCTestCase {

    typealias Ordinal = RelativeNamedInterval.Ordinal
    
    func testUnisonPerfectNotImperfect() {
        let unison = Ordinal.unison
        XCTAssert(Ordinal.perfects.contains(unison))
        XCTAssertFalse(Ordinal.imperfects.contains(unison))
    }
    
    func testSecondImperfectNotImperfect() {
        let second = Ordinal.second
        XCTAssert(Ordinal.imperfects.contains(second))
        XCTAssertFalse(Ordinal.perfects.contains(second))
    }
    
    func testSecondOrdinalInverseSeventh() {
        XCTAssertEqual(Ordinal.second.inverse, Ordinal.fourth)
    }
    
    func testInverseMajorThirdMinorThird() {
        let M3 = RelativeNamedInterval(.major, .third)
        let m3 = RelativeNamedInterval(.minor, .third)
        XCTAssertEqual(M3.inverse, m3)
    }
    
    func testInverseAugmentedFourthDiminishedSecond() {
        let A4 = RelativeNamedInterval(.augmented, .fourth)
        let d2 = RelativeNamedInterval(.diminished, .second)
        XCTAssertEqual(A4.inverse, d2)
        XCTAssertEqual(d2.inverse, A4)
    }
}
