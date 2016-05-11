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
    
    /**
    `true` if `coarse.direction` values of both `PitchSpelling` objects are equivalent.
     Otherwise `false`.
     */
    public var isCoarseDirectionMatching: Bool {
        return lower.coarse.direction == higher.coarse.direction
    }
    
    /**
     `true if `fine` values of `PitchSpelling` objects are equivalent. Otherwise `false`..
     */
    public var isFineMatching: Bool { return lower.fine == higher.fine }
    
    public var isStepPreserving: Bool { return intervalQuality.isStepPreserving }
    
    /// Mean of `distance` values of both `PitchSpelling` objects.
    public var meanDistance: Float { return [lower.distance, higher.distance].mean! }
    
    /// Amount of steps between two `PitchSpelling` objects.
    public var steps: Int {
        let difference = higher.letterName.steps - lower.letterName.steps
        return abs(Int.mod(difference, 7))
    }

    /// `IntervalQuality` between `PitchSpelling` objects.
    public var intervalQuality: IntervalQualityKind {
        //let family = IntervalQuality.intervalFamily(withAmountOfSteps: steps)
        
        //return family.kind(lower.coarse, higher.coarse)
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
