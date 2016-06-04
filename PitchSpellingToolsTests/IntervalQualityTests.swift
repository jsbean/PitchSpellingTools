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

    func testIntervalQuality() {
        let m3 = IntervalQuality.third.minor
        XCTAssert(IntervalQuality.third.has(m3))
    }
    
    func testAugmentedFourthStepPreserving() {
        let A4 = IntervalQuality.fourth.augmented
        XCTAssertTrue(A4.hasIntervalFidelity)
    }
    
    func testDiminishedFifthStepPreserving() {
        
    }
}

