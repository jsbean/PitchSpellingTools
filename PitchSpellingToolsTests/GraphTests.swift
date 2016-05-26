//
//  GraphTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/26/16.
//
//

import XCTest
import ArithmeticTools
import Pitch
@testable import PitchSpellingTools

class GraphTests: XCTestCase {

    func testInitWithEmptyPitchSet() {
        let _ = Graph(pitchSet: [])
    }
    
    func testInitWithMonadPitchSet() {
        
        var graph = Graph(
            pitchSet: [
                Pitch(noteNumber: 60)
            ]
        )
        
        XCTAssertEqual(graph.levels.count, 1)
    }
    
    func testInitWithDyadPitchSet() {
        
        var graph = Graph(
            pitchSet: [
                Pitch(noteNumber: 60),
                Pitch(noteNumber: 67)
            ]
        )
        
        XCTAssertEqual(graph.levels.count, 2)
        XCTAssertEqual(graph.allPaths.count, 9)
    }
    
    func testInitWithTriadPitchSet() {
        
        var graph = Graph(
            pitchSet: [
                Pitch(noteNumber: 60),
                Pitch(noteNumber: 67),
                Pitch(noteNumber: 69)
            ]
        )
        
        XCTAssertEqual(graph.levels.count, 3)
        XCTAssertEqual(graph.allPaths.count, 3 * 3 * 3)
    }
    
    func testInitWithTetrachordWithQuarterTones() {
        
        var graph = Graph(
            pitchSet: [
                Pitch(noteNumber: 60),
                Pitch(noteNumber: 67.5),
                Pitch(noteNumber: 70.5),
                Pitch(noteNumber: 71)
            ]
        )
        
        XCTAssertEqual(graph.levels.count, 4)
        XCTAssertEqual(graph.allPaths.count, 3 * 2 * 2 * 3)
    }
    
    func testPathsDoNotAllowUnconventionalEnharmonicsCNatural() {
        var graph = Graph(pitchSet: [Pitch.middleC])
        let paths = graph.paths(allowingUnconventionalEnharmonics: false)
        XCTAssertEqual(paths.count, 1)
    }
    
    func testPathsAllowUnconventionalEnharmonicsCNatural() {
        var graph = Graph(pitchSet: [Pitch.middleC])
        let paths = graph.paths(allowingUnconventionalEnharmonics: true)
        XCTAssertEqual(paths.count, 3)
    }
    
    func testPathsDoNotAllowUnconventionalEnharmonicsEb() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 63)])
        let paths = graph.paths(allowingUnconventionalEnharmonics: false)
        XCTAssertEqual(paths.count, 2)
    }
    
    func testPathsAllowUnconventionalEnharmonicsEFlat() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 63)])
        let paths = graph.paths(allowingUnconventionalEnharmonics: true)
        XCTAssertEqual(paths.count, 3)
    }
    
    func testPathsCompatibleWithFineDirection_C_up() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60.25)])
        let paths = graph.paths(compatibleWithFineDirection: .up)
        XCTAssertEqual(paths.count, 1)
    }
    
    func testPathsCompatibleWithFineDirection_C_qtr_down() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60.25)])
        let paths = graph.paths(compatibleWithFineDirection: .down)
        XCTAssertEqual(paths.count, 2)
    }
    
    func testPathsCompatibleWithCoarseDirectionCSharp() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 61)])
        let paths = graph.paths(compatibleWithCoarseDirection: .up)
        XCTAssertEqual(paths.count, 1)
    }
    
    func testPathsCompatibleWithCoarseDirectionDFlat() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 61)])
        let paths = graph.paths(compatibleWithCoarseDirection: .down)
        XCTAssertEqual(paths.count, 1)
    }
    
    func testPathsCompatibleWithNaturalCSharpOrDFlat() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 61)])
        let paths = graph.paths(compatibleWithCoarseDirection: .none)
        XCTAssertEqual(paths.count, 2)
    }
    
    func testPathsCompatibleWithCoarseDirection() {
        
        var graph = Graph(
            pitchSet: [
                Pitch(noteNumber: 60),
                Pitch(noteNumber: 67.5),
                Pitch(noteNumber: 70.5),
                Pitch(noteNumber: 71)
            ]
        )
        let _ = graph.paths(compatibleWithCoarseDirection: .up)
        let _ = graph.paths(compatibleWithFineDirection: .down)
        let _ = graph.paths(
            compatibleWithCoarseDirection: .down,
            compatibleWithFineDirection: .down
        )
    }
}
