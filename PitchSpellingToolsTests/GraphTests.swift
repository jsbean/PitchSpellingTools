//
//  GraphTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class GraphTests: XCTestCase {

    func testInitWithEmptyPitchSet() {
        let _ = Graph(pitchSet: [])
    }
    
    func testInitWithMonadPitchSet() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60)])
        XCTAssertEqual(graph.levels.count, 1)
        XCTAssertEqual(graph.nodes.count, 3)
    }
    
    func testInitWithDyadPitchSet() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60), Pitch(noteNumber: 67)])
        XCTAssertEqual(graph.levels.count, 2)
    }
}
