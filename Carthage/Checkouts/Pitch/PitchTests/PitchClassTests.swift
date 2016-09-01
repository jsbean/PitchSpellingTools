//
//  PitchClassTests.swift
//  Pitch
//
//  Created by James Bean on 5/7/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import ArithmeticTools
@testable import Pitch

class PitchClassTests: XCTestCase {

    func testPitchClass() {
        let pitch = Pitch(noteNumber: 60.0)
        XCTAssert(pitch.pitchClass == 0.0)
    }
    
    func testPitchClassInitFloatLessThan12() {
        let _: PitchClass = 3.0
    }
    
    func testPitchClassInitFloatGreaterThan12() {
        let pc: PitchClass = 13.5
        XCTAssertEqual(pc, 1.5)
    }
    
    func testPitchClassInitIntLessThan12() {
        let _: PitchClass = 6
    }
    
    func testPitchClassInitIntGreaterThan12() {
        let pc: PitchClass = 15
        XCTAssertEqual(pc, 3)
    }
    
    func testPitchClassInitWithFloat() {
        let _: PitchClass = 15.0
    }
}
