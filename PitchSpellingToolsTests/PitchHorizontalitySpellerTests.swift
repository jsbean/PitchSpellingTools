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
        let speller = PitchHorizontalitySpeller(pitches: [Pitch.middleC])
        XCTAssertEqual(try speller.spell(), [SpelledPitch(60, PitchSpelling(.c))])
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
    
    func testCDFlatEFlat() {
        let speller = PitchHorizontalitySpeller(
            pitches: [Pitch(noteNumber: 60), Pitch(noteNumber: 61), Pitch(noteNumber: 63)]
        )
        do {
            let spelledPitches = try speller.spell()
            XCTAssertEqual(
                Set(spelledPitches),
                [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 60), spelling: PitchSpelling(.c)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 61), spelling: PitchSpelling(.d, .flat)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 63), spelling: PitchSpelling(.e, .flat)
                    )
                ]
            )
        } catch { XCTFail() }
    }
    
    func test_63_66_68() {
        let speller = PitchHorizontalitySpeller(
            pitches: [Pitch(noteNumber: 63), Pitch(noteNumber: 66), Pitch(noteNumber: 68)]
        )
        do {
            let spelledPitches = try speller.spell()
            XCTAssertEqual(
                Set(spelledPitches),
                [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 63), spelling: PitchSpelling(.d, .sharp)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 66), spelling: PitchSpelling(.f, .sharp)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 68), spelling: PitchSpelling(.g, .sharp)
                    )
                ]
            )
        } catch { XCTFail() }
    }
    
    func test__65_5__69_25() {
        let speller = PitchHorizontalitySpeller(
            pitches: [Pitch(noteNumber: 65.5), Pitch(noteNumber: 69.25)]
        )
        do {
            let spelledPitches = try speller.spell()
            XCTAssertEqual(
                Set(spelledPitches),
                [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 65.5), spelling: PitchSpelling(.f, .quarterSharp)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 69.25), spelling: PitchSpelling(.a, .quarterSharp, .down)
                    )
                ]
            )
        } catch { XCTFail() }
    }
    
    func test_60_61_62() {
        let speller = PitchHorizontalitySpeller(
            pitches: [Pitch(noteNumber: 60), Pitch(noteNumber: 61), Pitch(noteNumber: 62)]
        )
        do {
            let spelledPitches = try speller.spell()
            XCTAssertEqual(
                Set(spelledPitches),
                [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 60), spelling: PitchSpelling(.c)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 61), spelling: PitchSpelling(.c, .sharp)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 62), spelling: PitchSpelling(.d)
                    )
                ]
            )
        } catch { XCTFail() }
    }
}
