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

    func testInitWithNothing() {
        let _ = PitchSet()
    }

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
}
