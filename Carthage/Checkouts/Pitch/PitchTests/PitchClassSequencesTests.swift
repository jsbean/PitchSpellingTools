//
//  PitchClassSequencesTests.swift
//  Pitch
//
//  Created by James Bean on 6/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import Pitch

class PitchClassSequencesTests: XCTestCase {

    func testInitArrayliteral() {
        let _: PitchClassSequence = [0,1,6]
    }
    
    func testIntervals() {
        var seq: PitchClassSequence = [0,1,6]
        XCTAssertEqual(seq.intervals!, [1,5])
    }
    
    func testRetrograde() {
        let seq: PitchClassSequence = [6,7,8,9,2]
        XCTAssertEqual(seq.retrograde, [2,9,8,7,6])
    }
    
    func testInversion() {
        let seq: PitchClassSequence = [6,7,8,9,2]
        XCTAssertEqual(seq.inversion, [6,5,4,3,10])
    }
}

