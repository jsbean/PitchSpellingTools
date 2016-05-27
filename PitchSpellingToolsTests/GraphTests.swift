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
        let _ = Graph(pitchSet: [Pitch(noteNumber: 60)])
    }
    
    func testInitWithDyadPitchSet() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60), Pitch(noteNumber: 67)])
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
    
    func testPathsCompatibleWithCoarseDSharpGSharp() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 63), Pitch(noteNumber: 68)])
        let paths = graph.paths(compatibleWithCoarseDirection: .up)
        XCTAssertEqual(paths.count, 1)
    }
    
    func testPathsCompatibleWithCoarseEFlatAFlat() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 63), Pitch(noteNumber: 68)])
        let paths = graph.paths(compatibleWithCoarseDirection: .down)
        XCTAssertEqual(paths.count, 1)
    }
    
    func testPathCompatibleWithCoarseEitherSharpOrFlatButNotUnconventional() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 63), Pitch(noteNumber: 68)])
        let paths = graph.paths()
        
        // Eb -> Ab, Eb -> G#, D# -> G#, D# -> Ab
        XCTAssertEqual(paths.count, 4)
    }
    
    func testPathCompatibleWithCoarseEFlatAFlatThenDSharpGSharp() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 63), Pitch(noteNumber: 68)])
        let sharpSide = graph.paths(compatibleWithCoarseDirection: .up)
        XCTAssertEqual(sharpSide.count, 1)
        let flatSide = graph.paths(compatibleWithCoarseDirection: .down)
        XCTAssertEqual(flatSide.count, 1)
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
    
    func testTriadCFAFlatOrGSharp() {
        var graph = Graph(
            pitchSet: [
                Pitch(noteNumber: 60),
                Pitch(noteNumber: 65),
                Pitch(noteNumber: 68)
            ]
        )
        let paths = graph.paths
        let stepPreservingPaths = paths.stepPreserving

        // C -> F -> Ab, not C -> F -> G#
        XCTAssertEqual(stepPreservingPaths.count, 1)
    }
    
    func testTriad_61_69_66() {
        var graph = Graph(
            pitchSet: [
                Pitch(noteNumber: 66),
                Pitch(noteNumber: 61),
                Pitch(noteNumber: 69)
            ]
        )
        let paths = graph.paths
        let stepPreservingPaths = paths.stepPreserving
        XCTAssertEqual(stepPreservingPaths.count, 1)
    }
    
    func testDyad_61_66() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 66), Pitch(noteNumber: 61)])
        let paths = graph.paths
        let stepPreservingPaths = paths.stepPreserving
        
        // C# -> G# || Db -> Gb
        XCTAssertEqual(stepPreservingPaths.count, 2)
    }
    
    func testQuarterStepDyad() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60.5), Pitch(noteNumber: 65.5)])
        let paths = graph.paths
        let stepPreservingPaths = paths.stepPreserving
        XCTAssertEqual(stepPreservingPaths.count, 2)
    }
    
    func testMixedWholeStepQuarterStepTriad() {
        var graph = Graph(
            pitchSet: [
                Pitch(noteNumber: 60.5),
                Pitch(noteNumber: 65.5),
                Pitch(noteNumber: 68)
            ]
        )
        let paths = graph.paths
        let stepPreservingPaths = paths.stepPreserving
        XCTAssertEqual(stepPreservingPaths.count, 2)
    }
    
    func testEighthToneDyad() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60.25), Pitch(noteNumber: 65.75)])
        let paths = graph.paths
        let stepPreservingPaths = paths.stepPreserving
        XCTAssertEqual(stepPreservingPaths.count, 7)
        let fineCompatiblePaths = paths.fineCompatible
        let intersection = Set(stepPreservingPaths).intersect(fineCompatiblePaths)
        XCTAssertEqual(intersection.count, 3)
    }

    func testManyPitchesTiming() {
        let amountPitches = 14
        let pitchArray = (0 ..< amountPitches).map { _ in
            Pitch(noteNumber: NoteNumber(Float.random(min: 60, max: 72)))
        }
        print("pitchArray: \(pitchArray)")
        let pitchSet = PitchSet(pitchArray)
        var graph = Graph(pitchSet: pitchSet)
        self.measureBlock {
            let _ = graph.paths()
        }
    }
    
    func testApplyFiltersToPathsFailure() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60.25), Pitch(noteNumber: 60.5)])
        graph.paths.applyFiltersToPaths()
    }
    
    func testApplyFiltersToPaths() {
        var graph = Graph(pitchSet: [Pitch(noteNumber: 60.25), Pitch(noteNumber: 65.75)])
        graph.paths.applyFiltersToPaths()
    }
}
