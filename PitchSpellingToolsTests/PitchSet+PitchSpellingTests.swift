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

    func testSpellabilityEmptyObjective() {
        let pitchSet: PitchSet = []
        XCTAssert(pitchSet.spellability == .objective)
    }
    
    func testSpellabilitySingleObjective() {
        let pitchSet: PitchSet = [69]
        XCTAssert(pitchSet.spellability == .objective)
    }
    
    func testSpellabilitySingleFullyAmbiguous() {
        let pitchSet: PitchSet = [70]
        XCTAssert(pitchSet.spellability == .fullyAmbiguous)
    }

    func testSpellabilityTriadSemiAmbiguous() {
        let pitchSet: PitchSet = [63,66,69]
        XCTAssert(pitchSet.spellability == .semiAmbiguous)
    }
    
    func testSpellabilityTriadFullyAmbiguous() {
        let pitchSet: PitchSet = [63,66,68]
        XCTAssert(pitchSet.spellability == .fullyAmbiguous)
    }
}
