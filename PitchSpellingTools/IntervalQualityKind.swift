//
//  IntervalQualityKind.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/11/16.
//
//

import Foundation

/**
 All interval qualities with a half-step resolution.
 Flat resource which is wrapped hierarchically by `IntervalQuality`.
 */
public enum IntervalQualityKind: String {
    
    case diminishedUnison = "d1"
    case perfectUnison = "P1"
    case augmentedUnison = "A1"
    
    case diminishedSecond = "d2"
    case minorSecond = "m2"
    case majorSecond = "M2"
    case augmentedSecond = "A2"
    
    case diminishedThird = "d3"
    case minorThird	= "m3"
    case majorThird	= "M3"
    case augmentedThird = "A3"
    
    case diminishedFourth = "d4"
    case perfectFourth = "P4"
    case augmentedFourth = "A4"
    
    case diminishedFifth = "d5"
    case perfectFifth = "P5"
    case augmentedFifth = "A5"
    
    case diminishedSixth = "d6"
    case minorSixth = "m6"
    case majorSixth = "M6"
    case augmentedSixth = "A6"
    
    case diminishedSeventh = "d7"
    case minorSeventh = "m7"
    case majorSeventh = "M7"
    case augmentedSeventh = "A7"
    
    // TODO: find a way to do this by reducing from each subfamily
    internal static var stepPreserving: [IntervalQualityKind] = [
        .perfectUnison,
        .minorSecond,
        .majorSecond,
        .minorThird,
        .majorThird,
        .perfectFourth,
        .perfectFifth,
        .minorSixth,
        .majorSixth,
        .minorSeventh,
        .majorSeventh
    ]
    
    public var isStepPreserving: Bool {
        return IntervalQualityKind.stepPreserving.contains(self)
    }
}