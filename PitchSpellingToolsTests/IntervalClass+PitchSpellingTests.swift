//
//  IntervalClass+PitchSpellingTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class IntervalClass_PitchSpellingTests: XCTestCase {

    func testOctaveLessComplexThanPerfectFifth() {
        let p5: IntervalClass = 7
        let p8: IntervalClass = 0
        XCTAssert(p8.spellingPriority < p5.spellingPriority)
    }
    
    func testPerfectFifthLessComplexThanMajorThird() {
        let p5: IntervalClass = 7
        let M3: IntervalClass = 4
        XCTAssert(p5.spellingPriority < M3.spellingPriority)
    }
}
