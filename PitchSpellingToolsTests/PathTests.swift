//
//  PathTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

//class PathTests: XCTestCase {
//
//    func testMeanCoarseDistanceZero() {
//        let path = Path(nodes: [PitchSpellingNode(pitch: Pitch.middleC, spelling: PitchSpelling(.c))])
//        XCTAssertEqual(path.meanCoarseDistance, 0)
//    }
//    
//    func testMeanCoarseDistanceSharpOne() {
//        let path = Path(nodes: [PitchSpellingNode(spelling: PitchSpelling(.c, .sharp))])
//        XCTAssertEqual(path.meanCoarseDistance, 1)
//    }
//    
//    func testMeanCoarseDistanceFlatOne() {
//        let path = Path(nodes: [PitchSpellingNode(spelling: PitchSpelling(.b, .flat))])
//        XCTAssertEqual(path.meanCoarseDistance, 1)
//    }
//    
//    func testMeanCoarseDistanceThreeQuarters() {
//        let path = Path(nodes: [PitchSpellingNode(spelling: PitchSpelling(.b, .threeQuarterFlat))])
//        XCTAssertEqual(path.meanCoarseDistance, 1.5)
//    }
//}