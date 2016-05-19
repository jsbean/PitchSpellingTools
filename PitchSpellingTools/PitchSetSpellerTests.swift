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

    func testInit() {
        let set: PitchSet = [
            Pitch(noteNumber: 60), Pitch(noteNumber: 63), Pitch(noteNumber: 65)
        ]
        let _ = PitchSetSpeller(set)
        
    }
}
