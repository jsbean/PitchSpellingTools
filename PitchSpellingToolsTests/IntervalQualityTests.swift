//
//  IntervalQualityTests.swift
//  Pitch
//
//  Created by James Bean on 4/30/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import EnumTools
import Pitch
@testable import PitchSpellingTools

class IntervalQualityTests: XCTestCase {

    func testIntervalQuality() {
        let m3 = IntervalQuality.Third.Minor
        XCTAssert(IntervalQuality.Third.has(m3))
    }
}
