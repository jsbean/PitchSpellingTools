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
    func testEmptyThrows() {
        let speller = PitchHorizontalitySpeller(pitches: [])
        do {
            try speller.spell()
            XCTFail()
        } catch { }
    }
    
    func testMiddleC() {
        let speller = PitchHorizontalitySpeller(pitches: [Pitch.middleC])
        do {
            let spelledPitches = try speller.spell()
            XCTAssertEqual(
                spelledPitches,
                [
                    SpelledPitch(pitch: Pitch(noteNumber: 60), spelling: PitchSpelling(.c))
                ]
            )
            
        } catch { XCTFail() }
    }
    

    func testAFlat() {
        let speller = PitchHorizontalitySpeller(pitches: [Pitch(noteNumber: 68)])
        do {
            let spelledPitches = try speller.spell()
            XCTAssertEqual(
                spelledPitches,
                [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 68), spelling: PitchSpelling(.a, .flat)
                    )
                ]
            )
            
        } catch { XCTFail() }
    }
    
    func testCG() {
        let speller = PitchHorizontalitySpeller(
            pitches: [Pitch(noteNumber: 60), Pitch(noteNumber: 67)]
        )
        do {
            let spelledPitches = try speller.spell()
            XCTAssertEqual(
                spelledPitches,
                [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 60), spelling: PitchSpelling(.c)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 67), spelling: PitchSpelling(.g)
                    )
                ]
            )
            
        } catch { XCTFail() }
    }
    
    func testCEFlat() {
        let speller = PitchHorizontalitySpeller(
            pitches: [Pitch(noteNumber: 60), Pitch(noteNumber: 63)]
        )
        do {
            let spelledPitches = try speller.spell()
            XCTAssertEqual(
                spelledPitches,
                [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 60), spelling: PitchSpelling(.c)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 63), spelling: PitchSpelling(.e, .flat)
                    )
                ]
            )
            
        } catch { XCTFail() }
    }
}
