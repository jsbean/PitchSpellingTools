//
//  NamedIntervalQualityTests.swift
//  PitchSpellingTools
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import PitchSpellingTools

class NamedIntervalQualityTests: XCTestCase {

    func testInverseDimAug() {
        let dim = NamedIntervalQuality.diminished
        let aug = NamedIntervalQuality.augmented
        XCTAssertEqual(dim.inverse, aug)
        XCTAssertEqual(aug.inverse, dim)
    }
    
    func testInverseMinorMajor() {
        let maj = NamedIntervalQuality.major
        let min = NamedIntervalQuality.minor
        XCTAssertEqual(maj.inverse, min)
        XCTAssertEqual(min.inverse, maj)
    }
    
    func testInversePerfect() {
        let perfect = NamedIntervalQuality.perfect
        XCTAssertEqual(perfect.inverse, perfect)
    }
    
    func testDegreeSubscriptSinglePerfectNotNil() {
        let perfect = NamedIntervalQuality.perfect[.single]
        XCTAssertNotNil(perfect)
    }
    
    func testDegreeSubscriptDoublePerfectNil() {
        let perfect = NamedIntervalQuality.perfect[.double]
        XCTAssertNil(perfect)
    }
    
    func testDegreeSubscriptDoubleMajorNil() {
        let major = NamedIntervalQuality.major[.double]
        XCTAssertNil(major)
    }
    
    func testDegreeSubscriptAugmentedNotNil() {
        let aug = NamedIntervalQuality.augmented[.double]
        XCTAssertNotNil(aug)
    }
    
    func testInitNeutralIntevalClassOrdinal() {
        
        // make a minor third
        
        let ordinal = RelativeNamedInterval.Ordinal.third
        let neutralInterval: Float = 3
        let quality = NamedIntervalQuality(
            neutralIntervalClass: neutralInterval,
            ordinal: ordinal
        )
        
        print("quality: \(quality)")
    }
}