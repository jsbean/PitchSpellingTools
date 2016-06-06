//
//  PitchSpellingNodeResourceTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/6/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchSpellingNodeResourceTests: XCTestCase {
    
    func testAddressEqualAfterCopy() {
        let resourceA = PitchSpellingNodeResource(pitches: [60])
        let resourceB = resourceA
        XCTAssertEqual(unsafeAddressOf(resourceA[60]!), unsafeAddressOf(resourceB[60]!))
    }
    
    func testAddressEqualAfterSubscriptPitchSetSubset() {
        let aLotOfPitches: PitchSet = [60,61,62,63,64,65]
        let resourceA = PitchSpellingNodeResource(pitches: aLotOfPitches)
        let subset: PitchSet = [62, 65]
        let resourceB = resourceA[subset]!
        subset.forEach {
            XCTAssertEqual(unsafeAddressOf(resourceA[$0]!), unsafeAddressOf(resourceB[$0]!))
        }
    }
}
