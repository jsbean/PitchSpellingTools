//
//  Pitch+PitchSpellingTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/9/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class Pitch_PitchSpellingTests: XCTestCase {

    func test60DefaultSpellingC() {
        let pitch = Pitch(noteNumber: 60.0)
        XCTAssert(pitch.defaultSpelling == PitchSpelling(.c))
    }
}
