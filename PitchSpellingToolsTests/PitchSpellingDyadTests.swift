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
        // go through all possible intervals
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
        
    }
    
    func testCEFlatMinorThird() {
        
    }
    
    func testCSharpEFlatDiminishedThird() {
        
    }
}
