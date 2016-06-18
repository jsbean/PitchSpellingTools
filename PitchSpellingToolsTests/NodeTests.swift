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
        print(try! tree.spell())
    }
    
    func testBiggerSet() {
        let pitchSet: PitchSet = [60,61,66,68,70]
        let tree = Tree(pitchSet: pitchSet)
        print(try! tree.spell())
    }

    func testEighthTones() {
        self.measureBlock {
            let pitchSet: PitchSet = [60.25, 69.75]
            let tree = Tree(pitchSet: pitchSet)
            print(try! tree.spell())
        }
    }
    
    func testManyEighthTones() {
        let pitchSet: PitchSet = PitchSet((0 ..< 40).map { _ in Pitch.random(resolution: 4) })
        self.measureBlock {
            let tree = Tree(pitchSet: pitchSet)
            do {
                try tree.spell()
            } catch {
                print(error)
            }
            
        }
    }
    
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
