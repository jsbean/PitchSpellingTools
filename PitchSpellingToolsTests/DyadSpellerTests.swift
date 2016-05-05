//
//  DyadSpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/3/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class DyadSpellerTests: XCTestCase {

    func testPitchSpellingDyads() {
        let dyad = Dyad(Pitch(noteNumber: 61), Pitch(noteNumber: 68))
        let speller = DyadSpeller(dyad: dyad)
        XCTAssertEqual(speller.allPitchSpellingDyads.count, 4)
    }
    
    func testSpellCGWithDefaults() {
        //let dyad = Dyad(Pitch(noteNumber: 60), Pitch(noteNumber: 67))
        //var speller = DyadSpeller(dyad: dyad)
        //let spelledDyad = speller.spell()
    }
}
