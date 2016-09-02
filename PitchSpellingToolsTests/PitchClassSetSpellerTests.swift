//
//  PitchClassSetSpellerTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/25/16.
//
//

import XCTest
import Pitch
@testable import PitchSpellingTools

class PitchClassSetSpellerTests: XCTestCase {

    func testInit() {
        let pitchClassSet: PitchClassSet = [0,2,4]
        let speller = PitchClassSetSpeller(pitchClassSet)
        let _ = speller.spell()
    }
    
    // MARK: - Node Rule tests
    
    func testDoubleSharpOrDoubleFlatPenalized() {
        [PitchSpelling(.c, .doubleSharp), PitchSpelling(.g, .doubleFlat)].forEach {
            XCTAssertEqual(doubleSharpOrDoubleFlat(1)($0), 1)
        }
    }
    
    func testDoubleSharpOrDoubleFlatNotPenalized() {
        [PitchSpelling(.a, .threeQuarterSharp), PitchSpelling(.f, .quarterFlat)].forEach {
            XCTAssertEqual(doubleSharpOrDoubleFlat(1)($0), 0)
        }
    }
    
    func testThreeQuarterSharpOrThreeQuarterFlatPenalized() {
        [PitchSpelling(.d, .threeQuarterSharp), PitchSpelling(.e, .threeQuarterFlat)].forEach {
            XCTAssertEqual(threeQuarterSharpOrThreeQuarterFlat(1)($0), 1)
        }
    }
    
    func testThreeQuarterSharpOrThreeQuarterFlatNotPenalized() {
        [PitchSpelling(.d), PitchSpelling(.e, .sharp)].forEach {
            XCTAssertEqual(threeQuarterSharpOrThreeQuarterFlat(1)($0), 0)
        }
    }
    
    func testQuarterStepEighthStepCombinationPenalized() {
        let a = PitchSpelling(.d, .quarterSharp, .down)
        let b = PitchSpelling(.e, .threeQuarterFlat, .up)
        [a,b].forEach {
            XCTAssertEqual(quarterStepEighthStepCombination(1.0)($0), 1)
        }
    }
    
    func testQuarterStepEighthStepCombinationNotPenalized() {
        [PitchSpelling(.c), PitchSpelling(.b, .flat)].forEach {
            XCTAssertEqual(quarterStepEighthStepCombination(1.0)($0), 0)
        }
    }
}
