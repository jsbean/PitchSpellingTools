//
//  PitchSet+PitchSpellingTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/8/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchSet_PitchSpellingTests: XCTestCase {

    func testCanBeSpelledObjectivelyEmptyTrue() {
        let pitchSet: PitchSet = []
        XCTAssert(pitchSet.canBeSpelledObjectively)
    }
    
    func testCanBeSpelledObjectivelySingleTrue() {
        let pitchSet: PitchSet = [69]
        XCTAssert(pitchSet.canBeSpelledObjectively)
    }
    
    func testCanBeSpelledObjectivelySingleFalse() {
        let pitchSet: PitchSet = [70]
        XCTAssertFalse(pitchSet.canBeSpelledObjectively)
    }
    
    func testCanBeSpelledObjectivelyTriadFalse() {
        let pitchSet: PitchSet = [63,66,68]
        XCTAssertFalse(pitchSet.canBeSpelledObjectively)
    }
}
