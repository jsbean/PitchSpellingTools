//
//  NodeTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/17/16.
//
//

import XCTest
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
}
