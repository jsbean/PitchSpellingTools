//
//  PitchSpellingDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import ArithmeticTools

/**
 Pair of two `PitchSpellings objects.
 */
public struct PitchSpellingDyad {

    internal let lower: PitchSpelling
    internal let higher: PitchSpelling

    /**
    `true` if `coarse` values of both `PitchSpelling` objects are equivalent.
     Otherwise `false`.
     */
    public var isCoarseMatching: Bool { return lower.coarse == higher.coarse }
    
    public var isCoarseCompatible: Bool {
        return eitherIsNatural || isCoarseMatching
    }
    
    /**
    `true` if `coarse.direction` values of both `PitchSpelling` objects are equivalent.
     Otherwise `false`.
     */
    public var isCoarseDirectionMatching: Bool {
        return lower.coarse.direction == higher.coarse.direction
    }
    
    public var isCoarseDirectionCompatible: Bool {
        return eitherIsNatural || isCoarseDirectionMatching
    }
    
    public var isCoarseResolutionMatching: Bool {
        return lower.coarse.resolution == higher.coarse.resolution
    }
    
    public var isCoarseResolutionCompatible: Bool {
        return eitherIsNatural || isCoarseResolutionMatching
    }
    
    private var eitherIsNatural: Bool {
        return lower.coarse == .natural || higher.coarse == .natural
    }
    
    /**
     `true if `fine` values of `PitchSpelling` objects are equivalent. Otherwise `false`..
     */
    public var isFineMatching: Bool { return lower.fine == higher.fine }
    
    public var isFineCompatible: Bool {
        if lower.fine == .none || higher.fine == .none { return true }
        return isFineMatching
    }
    
    public var isStepPreserving: Bool { return intervalQuality.isStepPreserving }
    
    /// Mean of `distance` values of both `PitchSpelling` objects.
    public var meanSpellingDistance: Float {
        return [lower.spellingDistance, higher.spellingDistance].mean!
    }
    
    /// Amount of steps between two `PitchSpelling` objects.
    public var steps: Int {
        let difference = higher.letterName.steps - lower.letterName.steps
        return abs(Int.mod(difference, 7))
    }

    /// `IntervalQuality` between `PitchSpelling` objects.
    public var intervalQuality: IntervalQualityKind {
        return IntervalQuality.kind(forPitchSpellingDyad: self)
    }
    
    /**
     Create a `PitchSpellingDyad` with two `PitchSpelling` objects.
     */
    public init(_ lower: PitchSpelling, _ higher: PitchSpelling) {
        self.lower = lower
        self.higher = higher
    }
}

extension PitchSpellingDyad: Hashable {
    
    public var hashValue: Int { return lower.hashValue * higher.hashValue }
}

extension PitchSpellingDyad: Equatable { }

public func == (lhs: PitchSpellingDyad, rhs: PitchSpellingDyad) -> Bool {
    return lhs.lower == rhs.lower && lhs.higher == rhs.higher
}
