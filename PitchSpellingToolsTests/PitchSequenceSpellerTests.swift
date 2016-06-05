//
//  PitchHorizontalitySpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import XCTest
import ArithmeticTools
import Pitch
@testable import PitchSpellingTools

class PitchSequenceSpellerTests: XCTestCase {

    func testEmptyIsEmpty() {
        let speller = PitchSequenceSpeller(pitchSequence: [])
        do { XCTAssertEqual(try speller.spell(), []) }
    }
    
    func testMiddleC() {
        let speller = PitchSequenceSpeller(pitchSequence: [60])
        XCTAssertEqual(try speller.spell(), [SpelledPitch(60, PitchSpelling(.c))])
    }
    

    func testAFlat() {
        let speller = PitchSequenceSpeller(pitchSequence: [68])
        XCTAssertEqual(try speller.spell(), [SpelledPitch(68, PitchSpelling(.a, .flat))])
    }
    
    func testCG() {
        let speller = PitchSequenceSpeller(pitchSequence: [60,67])
        XCTAssertEqual(
            try speller.spell(),
            [
                SpelledPitch(60, PitchSpelling(.c)), SpelledPitch(67, PitchSpelling(.g))
            ]
        )
    }
    
    func testCEFlat() {
        let speller = PitchSequenceSpeller(pitchSequence: [60,63])
            XCTAssertEqual(
            try speller.spell(),
            [
                SpelledPitch(60, PitchSpelling(.c)),
                SpelledPitch(63, PitchSpelling(.e, .flat))
            ]
        )
    }
    
//    func testCDFlatEFlat() {
//        let speller = PitchSequenceSpeller(pitchSequence: [60,61,63])
//            XCTAssertEqual(
//            Set(try speller.spell()),
//            [
//                SpelledPitch(60, PitchSpelling(.c)),
//                SpelledPitch(61, PitchSpelling(.d, .flat)),
//                SpelledPitch(63, PitchSpelling(.e, .flat))
//            ]
//        )
//    }
    
    func test_63_66_68() {
        let speller = PitchSequenceSpeller(pitchSequence: [63,66,68])
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
        let speller = PitchSequenceSpeller(pitchSequence: [65.5, 69.25])
            XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(65.50, PitchSpelling(.f, .quarterSharp)),
                SpelledPitch(69.25, PitchSpelling(.a, .quarterSharp, .down))
            ]
        )
    }
    
    func test_60_61_62() {
        let speller = PitchSequenceSpeller(pitchSequence: [60,61,62])
        XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(60, PitchSpelling(.c)),
                SpelledPitch(61, PitchSpelling(.c, .sharp)),
                SpelledPitch(62, PitchSpelling(.d))
            ]
        )
    }
    
//    func testDDSharpFSharpG() {
//        let speller = PitchSequenceSpeller(pitchSequence: [62,63,66,67])
//        XCTAssertEqual(
//            Set(try speller.spell()),
//            [
//                SpelledPitch(62, PitchSpelling(.d)),
//                SpelledPitch(63, PitchSpelling(.d, .sharp)),
//                SpelledPitch(66, PitchSpelling(.f, .sharp)),
//                SpelledPitch(67, PitchSpelling(.g))
//            ]
//        )
//    }
    
    func testEFlatDFSharpG() {
        let speller = PitchSequenceSpeller(pitchSequence: [63,62,66,67])
        XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(62, PitchSpelling(.d)),
                SpelledPitch(63, PitchSpelling(.e, .flat)),
                SpelledPitch(66, PitchSpelling(.f, .sharp)),
                SpelledPitch(67, PitchSpelling(.g))
            ]
        )
    }
    
    func testEFlatDGFSharp() {
        let speller = PitchSequenceSpeller(pitchSequence: [63,62,67,66])
        XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(62, PitchSpelling(.d)),
                SpelledPitch(63, PitchSpelling(.e, .flat)),
                SpelledPitch(66, PitchSpelling(.f, .sharp)),
                SpelledPitch(67, PitchSpelling(.g))
            ]
        )
    }
    
    func testDDSharpE() {
        let speller = PitchSequenceSpeller(pitchSequence: [62,63,64])
        XCTAssertEqual(
            Set(try speller.spell()),
            [
                SpelledPitch(62, PitchSpelling(.d)),
                SpelledPitch(63, PitchSpelling(.d, .sharp)),
                SpelledPitch(64, PitchSpelling(.e))
            ]
        )
    }
    
    func testManypitchSequencePerformance() {
        self.measureBlock {
            let speller = PitchSequenceSpeller(
                pitchSequence: [60,61.5,63,64,65.25,66,67,69,70.25,75.5,72.5]
            )
            let _ = try? speller.spell()
        }
    }
    
    func testLongSequence() {
        let speller = PitchSequenceSpeller(
            pitchSequence: [63,62,67,66,68,69,70,71,63,64,62,59,60]
        )
        do {
            let spelledpitchSequence = try speller.spell()
            spelledpitchSequence.forEach {
                print($0)
            }
        } catch {
            
        }
    }
}

