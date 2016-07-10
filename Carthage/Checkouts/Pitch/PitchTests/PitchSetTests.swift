//
//  PitchSetTests.swift
//  Pitch
//
//  Created by James Bean on 5/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import Pitch

class PitchSetTests: XCTestCase {

    func testDyads() {
        var set = PitchSet(
            [
                Pitch(noteNumber: 60),
                Pitch(noteNumber: 61),
                Pitch(noteNumber: 62),
                Pitch(noteNumber: 63)
            ]
        )
        XCTAssertEqual(set.dyads!.count, 6)
    }
    
    func testArrayLiteralConvertible() {
        let _: PitchSet = [Pitch(noteNumber: 60), Pitch(noteNumber: 61)]
    }
    
    func testInitWithPitchSetsEmpty() {
        let pitchSets: [PitchSet] = []
        let pitchSet = PitchSet(pitchSets)
        XCTAssert(pitchSet.isEmpty)
    }
    
    func testInitWithPitchSetsSingle() {
        let pitchSets = [PitchSet([60])]
        let pitchSet = PitchSet(pitchSets)
        XCTAssertEqual(pitchSet, PitchSet([60]))
    }
    
    func testInitWithPitchSetsMultipleOverlapping() {
        let pitchSets = [PitchSet([60]), PitchSet([60,61]), PitchSet([65])]
        let pitchSet = PitchSet(pitchSets)
        XCTAssertEqual(pitchSet, PitchSet([60,61,65]))
    }
}
