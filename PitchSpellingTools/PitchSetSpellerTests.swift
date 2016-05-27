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

    func testMondadCNatural() {
        let pitchSet: PitchSet = [Pitch.middleC]
        let speller = PitchSetSpeller(pitchSet)
        try! speller.spell()
    }
}
