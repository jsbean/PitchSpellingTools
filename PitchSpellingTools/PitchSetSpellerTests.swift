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
    
    func testDyad_C_G_FSharp() {
        let pitchSet: PitchSet = [
            Pitch(noteNumber: 60), Pitch(noteNumber: 66), Pitch(noteNumber: 67)
        ]
        do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
    }
    
    func testDyad_A_CSharp_FSharp() {
        let pitchSet: PitchSet = [
            Pitch(noteNumber: 61),
            Pitch(noteNumber: 66),
            Pitch(noteNumber: 69)
        ]
        do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
    }
    
    func testDyad_69_70_71() {
        let pitchSet: PitchSet = [
            Pitch(noteNumber: 69),
            Pitch(noteNumber: 70),
            Pitch(noteNumber: 71)
        ]
        do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
    }
    
    func testDyad_60__62_5__69__70() {
        let pitchSet: PitchSet = [
            Pitch(noteNumber: 60),
            Pitch(noteNumber: 62.5),
            Pitch(noteNumber: 69),
            Pitch(noteNumber: 70)
        ]
        do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
    }
    
    func testCEFlatGAFlatB() {
        let pitchSet: PitchSet = [
            Pitch(noteNumber: 60),
            Pitch(noteNumber: 63),
            Pitch(noteNumber: 67),
            Pitch(noteNumber: 68),
            Pitch(noteNumber: 71)
        ]
        do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
    }
    
    func test_60__63_5__65__68() {
        let pitchSet: PitchSet = [
            Pitch(noteNumber: 60),
            Pitch(noteNumber: 63.5),
            Pitch(noteNumber: 65),
            Pitch(noteNumber: 68)
        ]
        do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
    }
}
