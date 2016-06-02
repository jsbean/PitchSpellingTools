//
//  PitchHorizontalitySpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchHorizontalitySpellerTests: XCTestCase {

    // empty
    func testEmptyIsEmpty() {
        let speller = PitchHorizontalitySpeller(pitches: [])
        do { XCTAssertEqual(try speller.spell(), []) }
    }
    
    func testMiddleC() {
        let speller = PitchHorizontalitySpeller(pitches: [60])
        XCTAssertEqual(try speller.spell(), [SpelledPitch(60, PitchSpelling(.c))])
    }
    

    func testAFlat() {
        let speller = PitchHorizontalitySpeller(pitches: [68])
        XCTAssertEqual(try speller.spell(), [SpelledPitch(68, PitchSpelling(.a, .flat))])
    }
    
    func testCG() {
        let speller = PitchHorizontalitySpeller(pitches: [60,67])
        XCTAssertEqual(
            try speller.spell(),
            [
                SpelledPitch(60, PitchSpelling(.c)), SpelledPitch(67, PitchSpelling(.g))
            ]
        )
    }
    
    func testCEFlat() {
        let speller = PitchHorizontalitySpeller(pitches: [60,63])
            XCTAssertEqual(
            try speller.spell(),
            [
                SpelledPitch(60, PitchSpelling(.c)),
                SpelledPitch(63, PitchSpelling(.e, .flat))
            ]
        )
    }
    
    func testCDFlatEFlat() {
        let speller = PitchHorizontalitySpeller(pitches: [60,61,63])
            XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(60, PitchSpelling(.c)),
                SpelledPitch(61, PitchSpelling(.d, .flat)),
                SpelledPitch(63, PitchSpelling(.e, .flat))
            ]
        )
    }
    
    func test_63_66_68() {
        let speller = PitchHorizontalitySpeller(pitches: [63,66,68])
        XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(63, PitchSpelling(.d, .sharp)),
                SpelledPitch(66, PitchSpelling(.f, .sharp)),
                SpelledPitch(68, PitchSpelling(.g, .sharp))
            ]
        )
    }
    
    func test__65_5__69_25() {
        let speller = PitchHorizontalitySpeller(pitches: [65.5, 69.25])
            XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(65.50, PitchSpelling(.f, .quarterSharp)),
                SpelledPitch(69.25, PitchSpelling(.a, .quarterSharp, .down))
            ]
        )
    }
    
    func test_60_61_62() {
        let speller = PitchHorizontalitySpeller(pitches: [60,61,62])
        XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(60, PitchSpelling(.c)),
                SpelledPitch(61, PitchSpelling(.c, .sharp)),
                SpelledPitch(62, PitchSpelling(.d))
            ]
        )
    }
    
    func testManyPitchesPerformance() {
        let pitches: [Pitch] = [60,61.5,63,64,65.25,66,67,69,70.25,75.5,72.5]
        self.measureBlock {
            let speller = PitchHorizontalitySpeller(pitches: pitches)
            let _ = try? speller.spell()
        }
    }
}
