//
//  PitchSetSpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/19/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchSetSpellerTests: XCTestCase {

    func testDyads() {
        let set: PitchSet = [
            Pitch(noteNumber: 60), Pitch(noteNumber: 63), Pitch(noteNumber: 65)
        ]
        let speller = PitchSetSpeller(set)
        XCTAssertEqual(
            speller.dyads,
            [
                Dyad(Pitch(noteNumber: 60.0), Pitch(noteNumber: 65.0)),
                Dyad(Pitch(noteNumber: 63.0), Pitch(noteNumber: 65.0)),
                Dyad(Pitch(noteNumber: 60.0), Pitch(noteNumber: 63.0))
            ]
        )
    }
}
