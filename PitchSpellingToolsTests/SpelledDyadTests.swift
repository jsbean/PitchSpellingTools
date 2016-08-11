//
//  SpelledDyadTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/11/16.
//
//

import XCTest
@testable import PitchSpellingTools

class SpelledDyadTests: XCTestCase {
    
    func testInitSorted() {
        let higher = SpelledPitch(60, PitchSpelling(.c))
        let lower = SpelledPitch(57, PitchSpelling(.a))
        let spelledDyad = SpelledDyad(higher, lower)
        XCTAssertEqual(higher, spelledDyad.higher)
        XCTAssertEqual(lower, spelledDyad.lower)
    }
    
    func assertNamedInterval(
        for spelledDyad: SpelledDyad,
        equals namedInterval: NamedInterval?
    )
    {
        XCTAssertEqual(spelledDyad.namedInterval, namedInterval)
    }
    
    let c = SpelledPitch(60, PitchSpelling(.c))
    let ddoubleflat = SpelledPitch(60, PitchSpelling(.d, .doubleFlat))
    let dflat = SpelledPitch(61, PitchSpelling(.d, .flat))
    let csharp = SpelledPitch(61, PitchSpelling(.c, .sharp))
    let dsharp = SpelledPitch(63, PitchSpelling(.d, .sharp))
    let f = SpelledPitch(65, PitchSpelling(.f))
    let fsharp = SpelledPitch(66, PitchSpelling(.f, .sharp))
    let g = SpelledPitch(67, PitchSpelling(.g))
    let gsharp = SpelledPitch(68, PitchSpelling(.g, .sharp))
    let bdoubleflat = SpelledPitch(69, PitchSpelling(.b, .doubleFlat))
    let bflat = SpelledPitch(70, PitchSpelling(.b, .flat))
    let gdoublesharp = SpelledPitch(81, PitchSpelling(.g, .doubleSharp))
    
    func testNamedIntervalPerfectUnison() {
        let spelledDyad = SpelledDyad(c,c)
        assertNamedInterval(for: spelledDyad, equals: NamedInterval(.perfect, .unison))
    }
    
    func testNamedIntervalMinorSecond() {
        assertNamedInterval(for: SpelledDyad(c,dflat), equals: NamedInterval(.minor, .second))
    }
    
    func testNamedIntervalPerfectFifth() {
        assertNamedInterval(for: SpelledDyad(c,g), equals: NamedInterval(.perfect, .fifth))
    }
    
    func testNamedIntervalAugmentedFifth() {
        assertNamedInterval(
            for: SpelledDyad(c,gsharp),
            equals: NamedInterval(.augmented, .fifth)
        )
    }
    
    func testNamedIntervalAugmentedFourth() {
        assertNamedInterval(
            for: SpelledDyad(c, fsharp),
            equals: NamedInterval(.augmented, .fourth)
        )
    }
    
    func testNamedIntervalDiminishedFourth() {
        assertNamedInterval(
            for: SpelledDyad(fsharp, bflat),
            equals: NamedInterval(.diminished, .fourth)
        )
    }
    
    func testNamedIntervalDoubleDiminishedFourth() {
        let quality = NamedInterval.Quality.diminished[.double]!
        assertNamedInterval(
            for: SpelledDyad(fsharp, bdoubleflat),
            equals: NamedInterval(quality, .fourth)
        )
    }
    
    func testNamedIntervalDiminishedSecond() {
        assertNamedInterval(
            for: SpelledDyad(c, ddoubleflat),
            equals: NamedInterval(.diminished, .second)
        )
    }
    
    func testNamedIntervalDoubleDiminishedSecond() {
        assertNamedInterval(
            for: SpelledDyad(csharp, ddoubleflat),
            equals: NamedInterval(.double, .diminished, .second)
        )
    }
    
    func testNamedIntervalAugmentedSecond() {
        assertNamedInterval(
            for: SpelledDyad(c, dsharp),
            equals: NamedInterval(.augmented, .second)
        )
    }
    
    func testDiminishedThird() {
        assertNamedInterval(
            for: SpelledDyad(dsharp, f),
            equals: NamedInterval(.diminished, .third)
        )
    }
    
    func testDoubleAugmentedSixth() {
        assertNamedInterval(
            for: SpelledDyad(bflat, gdoublesharp),
            equals: NamedInterval(.double, .augmented, .sixth)
        )
    }
}
