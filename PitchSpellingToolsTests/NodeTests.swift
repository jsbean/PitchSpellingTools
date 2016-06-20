//
//  NodeTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/17/16.
//
//

import XCTest
import ArithmeticTools
import ArrayTools
import Pitch
import PitchSpellingTools

class NodeTests: XCTestCase {
    
    func assert(
        pitches: [Pitch],
        isSpelledWith pitchSpellings: [PitchSpelling],
        allowingUnconventionalEnharmonics: Bool = true
    )
    {
        let pitchSet = PitchSet(pitches)
        let spelledPitchSet = SpelledPitchSet(
            zip(pitches, pitchSpellings).map { SpelledPitch($0.0, $0.1) }
        )
        XCTAssertEqual(
            try Tree(pitchSet: pitchSet).spell(), spelledPitchSet
        )
    }
    
//    func assert(pitches: [Pitch], isSpelledWith spellings: [PitchSpelling]) {
////        let pitches = Set(pitches)
////        let spellings = Set(spellings)
//        let expected = SpelledPitchSet(
//            zip(pitches, spellings).map { SpelledPitch($0.0, $0.1) }
//        )
//        XCTAssertEqual(try Tree(pitchSet: PitchSet(pitches)).spell(), expected)
//    }
    
//    func testMondadCNatural() {
//        let pitchSet: PitchSet = [Pitch.middleC]
//        let speller = PitchSetSpeller(pitchSet)
//        do { let _ = try speller.spell() } catch { XCTFail() }
//    }


    func testDyadCG() {
        self.measureBlock {
            self.assert([60,67], isSpelledWith: [PitchSpelling(.c), PitchSpelling(.g)])
        }
    }

    func testDyadCSharpGSharp() {
        assert([61,68], isSpelledWith: [PitchSpelling(.c, .sharp), PitchSpelling(.g, .sharp)])
    }

    func testDyadCDFlat() {
        assert([60,61], isSpelledWith: [PitchSpelling(.c), PitchSpelling(.d, .flat)])
    }

    func testDyad_C_G_FSharp() {
        assert(
            [60,66,67],
            isSpelledWith: [PitchSpelling(.c), PitchSpelling(.f, .sharp), PitchSpelling(.g)]
        )
    }

    func testTriad_A_CSharp_FSharp() {
        assert(
            [61,66,69],
            isSpelledWith: [
                PitchSpelling(.c, .sharp), PitchSpelling(.f, .sharp), PitchSpelling(.a)
            ]
        )
    }
    
    func testTriadBFlatCD() {
        assert(
            [58,60,62],
            isSpelledWith: [
                PitchSpelling(.b, .flat), PitchSpelling(.c), PitchSpelling(.d)
            ]
        )
    }
    
    func testTriadABFlatE() {
        assert(
            [57,58,64],
            isSpelledWith: [
                PitchSpelling(.a), PitchSpelling(.b, .flat), PitchSpelling(.e)
            ]
        )
    }

//    func testDyad_69_70_71() {
//        assert(
//            [69,70,71],
//            isSpelledWith: [PitchSpelling(.a), PitchSpelling(.b, .flat), PitchSpelling(.b)]
//        )
//    }

    func testDyad_60__62_5__69__70() {
        self.measureBlock {
            self.assert(
                [60,62.5,69,70],
                isSpelledWith: [
                    PitchSpelling(.c),
                    PitchSpelling(.e, .threeQuarterFlat),
                    PitchSpelling(.a),
                    PitchSpelling(.b, .flat)
                ]
            )
        }
    }

    func testCEFlatGAFlatB() {
        assert(
            [60,63,67,68,71],
            isSpelledWith: [
                PitchSpelling(.c),
                PitchSpelling(.e, .flat),
                PitchSpelling(.g),
                PitchSpelling(.a, .flat),
                PitchSpelling(.b)
            ]
        )
    }

    func test_60__63_5__65__68() {
        assert(
            [60,63.5,65,68],
            isSpelledWith: [
                PitchSpelling(.c),
                PitchSpelling(.e, .quarterFlat),
                PitchSpelling(.f),
                PitchSpelling(.a, .flat)
            ]
        )
    }

    func test_61__63_5__65_5() {
        assert(
            [61,63.5,65.5],
            isSpelledWith: [
                PitchSpelling(.c, .sharp),
                PitchSpelling(.d, .threeQuarterSharp),
                PitchSpelling(.f, .quarterSharp)
            ]
        )
    }

    func test_61_63_66() {
        assert(
            [61,63,66],
            isSpelledWith: [
                PitchSpelling(.c, .sharp),
                PitchSpelling(.d, .sharp),
                PitchSpelling(.f, .sharp)
            ]
        )
    }

    func testFBEFlatGSharpA() {
        assert(
            [65,71,68,69],
            isSpelledWith: [
                PitchSpelling(.f),
                PitchSpelling(.b),
                PitchSpelling(.g, .sharp),
                PitchSpelling(.a)
            ]
        )
    }

    func testCDFlatEFlatGFlatAFlatBFlat() {
        self.measureBlock {
            self.assert(
                [60,61,63,66,68,70],
                isSpelledWith: [
                    PitchSpelling(.c),
                    PitchSpelling(.d, .flat),
                    PitchSpelling(.e, .flat),
                    PitchSpelling(.g, .flat),
                    PitchSpelling(.a, .flat),
                    PitchSpelling(.b, .flat)
                ]
            )
        }
    }
    
    
    func testDDownEQuarterSharpDown() {
        self.assert(
            [61.75, 64.25],
            isSpelledWith: [
                PitchSpelling(.d, .quarterFlat, .up),
                PitchSpelling(.e, .natural, .up)
            ]
        )
    }

    // Test disallowing unconventional enharmonics and rolling back
    // If unconventional enharmonics allowed, double-flat chosen
    // If no unconventional enharmonics, we need to backtrack
    func testDSharpFSharpGSharpABFlat() {
        self.measureBlock {
            self.assert(
                [63,66,68,69,70],
                isSpelledWith: [
                    PitchSpelling(.e, .flat),
                    PitchSpelling(.f, .sharp),
                    PitchSpelling(.g, .sharp),
                    PitchSpelling(.a),
                    PitchSpelling(.b, .flat),
                ],
                allowingUnconventionalEnharmonics: false
            )
        }
    }
    
    func testGFThreeQuarterSharpUp() {
        self.measureBlock {
            self.assert(
                [67,66.75],
                isSpelledWith: [
                    PitchSpelling(.g),
                    PitchSpelling(.f, .threeQuarterSharp, .up)
                ]
            )
        }
    }

    func testUniquePitchesSortedFromDyads() {
        var pitchSet: PitchSet = [60,65,66,68]
        let unspelled = pitchSet.dyads!
            .sort { $0.interval.spellingPriority < $1.interval.spellingPriority }
            .flatMap { [$0.lower, $0.higher] }
            .unique
        XCTAssertEqual(unspelled, [65,66,60,68])
    }
    
    func testTreeGeneration() {
        let pitchSet: PitchSet = [62,63,66,67]
        let tree = Tree(pitchSet: pitchSet)
        print(try? tree.spell())
    }
    
    func testBiggerSet() {
        let pitchSet: PitchSet = [60,61,66,68,70]
        let tree = Tree(pitchSet: pitchSet)
        print(try? tree.spell())
    }

    func testEighthTones() {
        self.measureBlock {
            let pitchSet: PitchSet = [60.25, 69.75]
            let tree = Tree(pitchSet: pitchSet)
            print(try? tree.spell())
        }
    }
    
    func testEFQuarterFlat() {
        assert([64, 64.5], isSpelledWith: [PitchSpelling(.e), PitchSpelling(.f, .quarterFlat)])
    }
    
//    func testManyEighthToneDyadsEnsureSingleFineDirection() {
//        (0 ..< 1000).forEach { _ in
//            let pitchSet = PitchSet((0 ..< 2).map { _ in Pitch.random(resolution: 4) })
//            do {
//                let spelledPitchSet = try Tree(pitchSet: pitchSet).spell()
//                assertZeroOrOneFineDirection(in: spelledPitchSet)
//            } catch {
//                XCTFail()
//            }
//        }
//    }
    
    func assertZeroOrOneFineDirection(in spelledPitchSet: SpelledPitchSet) {
        
        XCTAssert(
            spelledPitchSet
                .map { $0.spelling.fine }
                .filter { $0 != .none }
                .unique
                .count <= 1
            ,
            "\(spelledPitchSet)"
        )
    }
    
//    func testManyEighthTones() {
//        let pitchSet: PitchSet = PitchSet((0 ..< 40).map { _ in Pitch.random(resolution: 4) })
//        self.measureBlock {
//            let tree = Tree(pitchSet: pitchSet)
//            do {
//                try tree.spell()
//            } catch {
//                print(error)
//            }
//            
//        }
//    }
    
//    func test48EighthStepPitches() {
//        let pitchSet = PitchSet(
//            Float(0).stride(to: 48, by: 0.25).map { Pitch(noteNumber: NoteNumber($0)) }
//        )
//        self.measureBlock {
//            let tree = Tree(pitchSet: pitchSet)
//            try! tree.spell()
//        }
//    }
}
