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
    
    func testMonophonicAscending() {
        let speller = PitchSubSequenceSpeller(sets: [[60], [61], [62]])
        speller.applyRankings()
        
        // TODO: add assertions
    }
    
    func testMonophoningDescending() {
        let speller = PitchSubSequenceSpeller(sets: [[62], [61], [60]])
        speller.applyRankings()
    }
    
    func testDyadPair() {
        let sets: [PitchSet] = [[62,63],[66,68]]
        let speller = PitchSubSequenceSpeller(sets: sets)
        speller.applyRankings()
        // TODO: add assertions
    }
    
    func testDyads() {
        let sets: [PitchSet] = [[60,62],[63,65],[61,70]]
        let speller = PitchSubSequenceSpeller(sets: sets)
        speller.applyRankings()
        // TODO: add assertions
    }
    
    func testFSharpGSharpA() {
        let sets: [PitchSet] = [[66],[68],[69]]
        let speller = PitchSubSequenceSpeller(sets: sets)
        print(try! speller.spell())
    }
    
    func testABFlatCDFlat() {
        let sets: [PitchSet] = [[69],[70],[72],[73]]
        let speller = PitchSubSequenceSpeller(sets: sets)
        print(try! speller.spell())
    }
//    
//    func testLongMonophonicSequenceHalfStep() {
//        let sequence: [PitchSet] = (0 ..< 1000).map { _ in
//            let pitch = Pitch(floatLiteral: Float(Int.random(min: 60, max: 72)))
//            return PitchSet([pitch])
//        }
//        self.measureBlock {
//            let speller = PitchSubSequenceSpeller(sets: sequence)
//            let _ = try! speller.spell()
//            //spelledPitchSets.forEach { print($0) }
//        }
//    }
//    
//    func testLongMonophonicSequenceQuarterStep() {
//        let sequence: [PitchSet] = (0 ..< 1000).map { _ in
//            let pitch = Pitch(floatLiteral: Float.random(min: 60, max: 72, resolution: 2))
//            return PitchSet([pitch])
//        }
//        self.measureBlock {
//            let speller = PitchSubSequenceSpeller(sets: sequence)
//            let _ = try! speller.spell()
//            //spelledPitchSets.forEach { print($0) }
//        }
//    }
//    
//    func testLongDyadicSequenceHalfStep() {
//        let sequence: [PitchSet] = (0 ..< 1000).map { _ in
//            let pitches = (0 ..< 2).map { _ in
//                Pitch(floatLiteral: Float(Int.random(min: 60, max: 72)))
//            }
//            return PitchSet(pitches)
//        }
//        self.measureBlock {
//            let speller = PitchSubSequenceSpeller(sets: sequence)
//            speller.applyRankings()
//        }
//    }
//    
//    func testLongDyadicSequenceQuarterStep() {
//        let sequence: [PitchSet] = (0 ..< 1000).map { _ in
//            let pitches = (0 ..< 2).map { _ in
//                Pitch(floatLiteral: Float.random(min: 60, max: 72, resolution: 2))
//            }
//            return PitchSet(pitches)
//        }
//        self.measureBlock {
//            let speller = PitchSubSequenceSpeller(sets: sequence)
//            speller.applyRankings()
//        }
//    }
//    
//    func testLongDyadicSequenceEighthStep() {
//        let sequence: [PitchSet] = (0 ..< 1000).map { _ in
//            let pitches = (0 ..< 2).map { _ in
//                Pitch(floatLiteral: Float.random(min: 60, max: 72, resolution: 4))
//            }
//            return PitchSet(pitches)
//        }
//        self.measureBlock {
//            let speller = PitchSubSequenceSpeller(sets: sequence)
//            let _ = try! speller.spell()
//        }
//    }
//    
//    func testLongTradicSequenceHalfStep() {
//        let sequence: [PitchSet] = (0 ..< 1000).map { _ in
//            let pitches = (0 ..< 3).map { _ in
//                Pitch(floatLiteral: Float.random(min: 60, max: 72, resolution: 1))
//            }
//            return PitchSet(pitches)
//        }
//        self.measureBlock {
//            let speller = PitchSubSequenceSpeller(sets: sequence)
//            let _ = try! speller.spell()
//            //spelledPitchSets.forEach { print($0) }
//        }
//    }
//    
//    func testLongTradicSequenceEighthStep() {
//        let sequence: [PitchSet] = (0 ..< 1000).map { _ in
//            let pitches = (0 ..< 3).map { _ in
//                Pitch(floatLiteral: Float.random(min: 60, max: 72, resolution: 4))
//            }
//            return PitchSet(pitches)
//        }
//        self.measureBlock {
//            let speller = PitchSubSequenceSpeller(sets: sequence)
//            let _ = try! speller.spell()
//            //spelledPitchSets.forEach { print($0) }
//        }
//    }
}

