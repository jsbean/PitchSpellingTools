//
//  PitchClassSetSpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/25/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchClassSetSpellerTests: XCTestCase {

    func testInit() {
        let pitchClassSet: PitchClassSet = [0,2,4]
        let speller = PitchClassSetSpeller(pitchClassSet)
        speller.spell()
    }
}
