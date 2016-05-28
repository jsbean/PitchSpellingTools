//
//  PitchSetSpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/19/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchSetSpellerTests: XCTestCase {

    func testMondadCNatural() {
        let pitchSet: PitchSet = [Pitch.middleC]
        let speller = PitchSetSpeller(pitchSet)
        do {
            let _ = try speller.spell()
        } catch {
            XCTFail()
        }
    }
    
    func testDyadCG() {
        let pitchSet: PitchSet = [Pitch(noteNumber: 60), Pitch(noteNumber: 67)]
        let speller = PitchSetSpeller(pitchSet)
        do {
            let spelledPitchSet = try speller.spell()
            XCTAssertEqual(
                spelledPitchSet,
                SpelledPitchSet(pitches: [
                    SpelledPitch(pitch: Pitch(noteNumber: 60), spelling: PitchSpelling(.c)),
                    SpelledPitch(pitch: Pitch(noteNumber: 67), spelling: PitchSpelling(.g))
                ])
            )
        } catch {
            XCTFail()
        }
    }
    
    func testDyadCSharpGSharp() {
        let pitchSet: PitchSet = [Pitch(noteNumber: 61), Pitch(noteNumber: 68)]
        let speller = PitchSetSpeller(pitchSet)
        do {
            let spelledPitchSet = try speller.spell()
            XCTAssertEqual(
                spelledPitchSet,
                SpelledPitchSet(pitches: [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 61), spelling: PitchSpelling(.c, .sharp)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 68), spelling: PitchSpelling(.g, .sharp)
                    )
                ])
            )
        } catch {
            XCTFail()
        }
    }
    
    func testDyadCDFlat() {
        let pitchSet: PitchSet = [Pitch(noteNumber: 60), Pitch(noteNumber: 61)]
        let speller = PitchSetSpeller(pitchSet)
        do {
            let spelledPitchSet = try speller.spell()
            XCTAssertEqual(
                spelledPitchSet,
                SpelledPitchSet(pitches: [
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 60), spelling: PitchSpelling(.c)
                    ),
                    SpelledPitch(
                        pitch: Pitch(noteNumber: 61), spelling: PitchSpelling(.d, .flat)
                    )
                ])
            )
        } catch {
            XCTFail()
        }
    }
    
    func testDyadCGFSharp() {
        let pitchSet: PitchSet = [
            Pitch(noteNumber: 60), Pitch(noteNumber: 66), Pitch(noteNumber: 67)
        ]
        let speller = PitchSetSpeller(pitchSet)
        do {
            let _ = try speller.spell()
        } catch {
            XCTFail()
        }
    }
}
