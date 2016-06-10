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

    func assertPitches(pitches: [Pitch], areSpelledWith spellings: [PitchSpelling]) {
        let expected = SpelledPitchSet(
            zip(pitches, spellings).map { SpelledPitch($0.0, $0.1) }
        )
        XCTAssertEqual(try PitchSetSpeller(PitchSet(pitches)).spell(), expected)
    }
    
    func testMondadCNatural() {
        let pitchSet: PitchSet = [Pitch.middleC]
        let speller = PitchSetSpeller(pitchSet)
        do { let _ = try speller.spell() } catch { XCTFail() }
    }
    
    func testDyadCG() {
        assertPitches([60,67], areSpelledWith: [PitchSpelling(.c), PitchSpelling(.g)])
    }
    
    func testDyadCSharpGSharp() {
        assertPitches(
            [61,68],
            areSpelledWith: [PitchSpelling(.c, .sharp), PitchSpelling(.g, .sharp)]
        )
    }
    
    func testDyadCDFlat() {
        assertPitches([60,61], areSpelledWith: [PitchSpelling(.c), PitchSpelling(.d, .flat)])
    }
    
    func testDyad_C_G_FSharp() {
        assertPitches(
            [60,66,67],
            areSpelledWith: [PitchSpelling(.c), PitchSpelling(.f, .sharp), PitchSpelling(.g)]
        )
    }
    
    func testDyad_A_CSharp_FSharp() {
        assertPitches(
            [61,66,69],
            areSpelledWith: [
                PitchSpelling(.c, .sharp), PitchSpelling(.f, .sharp), PitchSpelling(.a)
            ]
        )
    }
    
    func testDyad_69_70_71() {
        assertPitches(
            [69,70,71],
            areSpelledWith: [PitchSpelling(.a), PitchSpelling(.b, .flat), PitchSpelling(.b)]
        )
    }
    
    func testDyad_60__62_5__69__70() {
        assertPitches(
            [60,62.5,69,70],
            areSpelledWith: [
                PitchSpelling(.c),
                PitchSpelling(.e, .threeQuarterFlat),
                PitchSpelling(.a),
                PitchSpelling(.b, .flat)
            ]
        )
    }
    
    func testCEFlatGAFlatB() {
        assertPitches(
            [60,63,67,68,71],
            areSpelledWith: [
                PitchSpelling(.c),
                PitchSpelling(.e, .flat),
                PitchSpelling(.g),
                PitchSpelling(.a, .flat),
                PitchSpelling(.b)
            ]
        )
    }
    
    func test_60__63_5__65__68() {
        assertPitches(
            [60,63.5,65,68],
            areSpelledWith: [
                PitchSpelling(.c),
                PitchSpelling(.e, .quarterFlat),
                PitchSpelling(.f),
                PitchSpelling(.a, .flat)
            ]
        )
    }
    
    func test_61__63_5__65_5() {
        assertPitches(
            [61,63.5,65.5],
            areSpelledWith: [
                PitchSpelling(.c, .sharp),
                PitchSpelling(.d, .threeQuarterSharp),
                PitchSpelling(.f, .quarterSharp)
            ]
        )
    }
    
    func test_61_63_66() {
        assertPitches(
            [61,63,66],
            areSpelledWith: [
                PitchSpelling(.c, .sharp),
                PitchSpelling(.d, .sharp),
                PitchSpelling(.f, .sharp)
            ]
        )
    }
    
    func testFBEFlatGSharpA() {
        assertPitches(
            [65,71,68,69],
            areSpelledWith: [
                PitchSpelling(.f),
                PitchSpelling(.b),
                PitchSpelling(.g, .sharp),
                PitchSpelling(.a)
            ]
        )
    }
    
    func testCDFlatEFlatGFlatAFlatBFlat() {
        self.assertPitches(
            [60,61,63,66,68,70],
            areSpelledWith: [
                PitchSpelling(.c),
                PitchSpelling(.d, .flat),
                PitchSpelling(.e, .flat),
                PitchSpelling(.g, .flat),
                PitchSpelling(.a, .flat),
                PitchSpelling(.b, .flat)
            ]
        )
    }
    
    func testDSharpFSharpGSharpABFlat() {
        self.assertPitches(
            [63,66,68,69,70],
            areSpelledWith: [
                PitchSpelling(.d, .sharp),
                PitchSpelling(.f, .sharp),
                PitchSpelling(.g, .sharp),
                PitchSpelling(.a),
                PitchSpelling(.b, .flat),
            ]
        )
    }
    
    func testGFThreeQuarterSharpUp() {
        self.assertPitches(
            [67,66.75],
            areSpelledWith: [
                PitchSpelling(.g),
                PitchSpelling(.f, .threeQuarterSharp, .up)
            ]
        )
    }
    
    
    func testManyEighthToneDyadsEnsureSingleFineDirection() {
        (0 ..< 1000).forEach { _ in
            let pitchSet = PitchSet((0 ..< 2).map { _ in Pitch.random(resolution: 4) })
            do {
                let spelledPitchSet = try PitchSetSpeller(pitchSet).spell()
                assertZeroOrOneFineDirection(in: spelledPitchSet)
            } catch {
                XCTFail()
            }
        }
    }
    
    func testManyEighthToneSetsEnsureSingleFineDirection() {
        (0 ..< 1000).forEach { _ in
            let pitchSet = PitchSet((0 ..< Int.random(min: 2, max: 6)).map { _ in
                Pitch.random(resolution: 4)
            })
            do {
                let spelledPitchSet = try PitchSetSpeller(pitchSet).spell()
                assertZeroOrOneFineDirection(in: spelledPitchSet)
            } catch {
                XCTFail()
            }
        }
    }
    
    func assertZeroOrOneFineDirection(in spelledPitchSet: SpelledPitchSet) {
        print(spelledPitchSet)
        XCTAssert(
            spelledPitchSet
                .map { $0.spelling.fine }
                .filter { $0 != .none }
                .unique
                .count <= 1
        )
    }
    

//    // MARK: - Performance Testing
//    
//    func testManyPitchesHalfStep() {
//        
//        let pitchSet: PitchSet = [
//            Pitch(noteNumber: 60),
//            Pitch(noteNumber: 61),
//            Pitch(noteNumber: 62),
//            Pitch(noteNumber: 63),
//            Pitch(noteNumber: 64),
//            Pitch(noteNumber: 65),
//            Pitch(noteNumber: 66),
//            Pitch(noteNumber: 67),
//            Pitch(noteNumber: 68),
//            Pitch(noteNumber: 69),
//            Pitch(noteNumber: 70),
//            Pitch(noteNumber: 71)
//        ]
//        self.measureBlock {
//            do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
//        }
//    }
//    
//    func testManyPitchesQuarterStep() {
//        let pitchSet: PitchSet = [
//            Pitch(noteNumber: 60),
//            Pitch(noteNumber: 61.5),
//            Pitch(noteNumber: 62.5),
//            Pitch(noteNumber: 63),
//            Pitch(noteNumber: 64.5),
//            Pitch(noteNumber: 65),
//            Pitch(noteNumber: 66.5),
//            Pitch(noteNumber: 67),
//            Pitch(noteNumber: 68.5),
//            Pitch(noteNumber: 69),
//            Pitch(noteNumber: 70.5),
//            Pitch(noteNumber: 71)
//        ]
//        self.measureBlock {
//            do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
//        }
//    }
//    
//    func testManyPitchesEighthStep() {
//        let pitchSet: PitchSet = [
//            Pitch(noteNumber: 60.25),
//            Pitch(noteNumber: 61.5),
//            Pitch(noteNumber: 62.5),
//            Pitch(noteNumber: 63),
//            Pitch(noteNumber: 64.25),
//            Pitch(noteNumber: 65),
//            Pitch(noteNumber: 66.5),
//            Pitch(noteNumber: 67),
//            Pitch(noteNumber: 68.75),
//            Pitch(noteNumber: 69),
//            Pitch(noteNumber: 70.5),
//            Pitch(noteNumber: 71.25)
//        ]
//        self.measureBlock {
//            do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
//        }
//    }
//
//    func testSomePitchesEighthStep() {
//        let pitchSet: PitchSet = [
//            Pitch(noteNumber: 60.25),
//            Pitch(noteNumber: 61.5),
//            Pitch(noteNumber: 62.5),
//            Pitch(noteNumber: 63),
//            Pitch(noteNumber: 64.25),
//        ]
//        self.measureBlock {
//            do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
//        }
//    }
//    
//    func testSomePitcheseighthStepWithOneObjectivelySpellable() {
//        let pitchSet: PitchSet = [
//            Pitch(noteNumber: 60),
//            Pitch(noteNumber: 60.25),
//            Pitch(noteNumber: 61.5),
//            Pitch(noteNumber: 62.5),
//            Pitch(noteNumber: 63),
//            Pitch(noteNumber: 64.25)
//        ]
//        self.measureBlock {
//            do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
//        }
//    }
//
//    func test48EighthTonePitchesForPerformance() {
//        let nns = Float(60).stride(to: 72, by: 0.25)
//        let pitches = nns.map { Pitch(noteNumber: NoteNumber($0)) }
//        let pitchSet = PitchSet(pitches)
//        self.measureBlock {
//            do { let _ = try PitchSetSpeller(pitchSet).spell() } catch { XCTFail() }
//        }
//    }
}
