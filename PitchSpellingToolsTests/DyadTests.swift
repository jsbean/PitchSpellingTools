//
//  DyadTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/5/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class DyadTests: XCTestCase {

    func testFinestResolutionQuarterTone() {
        let dyad = Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 60.5))
        XCTAssertEqual(dyad.finestResolution, 0.5)
    }
    
    func testFinestResolutionEighthTone() {
        let dyad = Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 60.25))
        XCTAssertEqual(dyad.finestResolution, 0.25)
    }
    
    func testSpellabilityObjective() {
        let dyad = Dyad(60,65)
        XCTAssert(dyad.spellability == .objective)
    }
    
    func testSpellabilitySemiAmbiguous() {
        let dyad = Dyad(60,63)
        XCTAssert(dyad.spellability == .semiAmbiguous)
    }
    
    func testSpellabilityFullyAmbiguous() {
        let dyad = Dyad(61,63)
        XCTAssert(dyad.spellability == .fullyAmbiguous)
    }
}
