//
//  HalfToneDyadSpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/12/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class HalfToneDyadSpellerTests: XCTestCase {

    func testCG() {
        let dyad = Dyad(Pitch(noteNumber: 60.0), Pitch(noteNumber: 67.0))
        let speller = DyadSpeller.makeSpeller(forDyad: dyad)
        guard let options = speller?.options else { XCTFail(); return }
        switch options {
        case .single(let pitchSpellingDyad):
            let expected = PitchSpellingDyad(PitchSpelling(.c), PitchSpelling(.g))
            XCTAssertEqual(pitchSpellingDyad, expected)
        default: XCTFail()
        }
    }
    
    func test61_68() {
        let dyad = Dyad(Pitch(noteNumber: 61.0), Pitch(noteNumber: 68.0))
        let speller = DyadSpeller.makeSpeller(forDyad: dyad)
        guard let options = speller?.options else { XCTFail(); return }
        switch options {
        case .multiple(let pitchSpellingDyads):
            let expected = [
                PitchSpellingDyad(PitchSpelling(.c, .sharp), PitchSpelling(.g, .sharp)),
                PitchSpellingDyad(PitchSpelling(.d, .flat), PitchSpelling(.a, .flat))
            ]
            XCTAssertEqual(pitchSpellingDyads, expected)
        default: XCTFail()
        }
    }
}
