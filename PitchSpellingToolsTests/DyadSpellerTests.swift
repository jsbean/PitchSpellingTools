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

    func testFactoryHalfTone() {
        let dyad = Dyad(Pitch(noteNumber: 61), Pitch(noteNumber: 68))
        let speller = DyadSpeller.makeSpeller(forDyad: dyad)
        XCTAssertTrue(speller is HalfToneDyadSpeller)
    }
    
    func testFactoryQuarterTone() {
        let dyad = Dyad(Pitch(noteNumber: 61), Pitch(noteNumber: 67.5))
        let speller = DyadSpeller.makeSpeller(forDyad: dyad)
        XCTAssertTrue(speller is QuarterToneDyadSpeller)
    }
    
    func testFactoryEighthTone() {
        let dyad = Dyad(Pitch(noteNumber: 61.25), Pitch(noteNumber: 67.5))
        let speller = DyadSpeller.makeSpeller(forDyad: dyad)
        XCTAssertTrue(speller is EighthToneDyadSpeller)
    }
    
    func testFactoryNil() {
        let dyad = Dyad(Pitch(noteNumber: 61.25), Pitch(noteNumber: 61.8))
        let speller = DyadSpeller.makeSpeller(forDyad: dyad)
        XCTAssertNil(speller)
    }
    
    func testPitchSpellingDyads() {
        let dyad = Dyad(Pitch(noteNumber: 61), Pitch(noteNumber: 68))
        let speller = DyadSpeller(dyad: dyad)
        XCTAssertEqual(speller.pitchSpellingDyads.count, 4)
    }
    
    func testSpellCSharpGSharp() {
        let dyad = Dyad(Pitch(noteNumber: 61), Pitch(noteNumber: 68))
        guard let speller = DyadSpeller.makeSpeller(forDyad: dyad) else {
            XCTFail()
            return
        }
        switch speller.options {
        case .none, .single: XCTFail()
        case .multiple: break
        }
    }
}
