//
//  PitchSequenceSpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/8/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchSequenceSpellerTests: XCTestCase {

    func testSubSequencesSingle() {
        let sets: [PitchSet] = [[60]]
        let speller = PitchSequenceSpeller(sets: sets)
        let expected: [[PitchSet]] = [[[60]]]
        //XCTAssertEqual(speller.subSequences, expected)
    }
}
