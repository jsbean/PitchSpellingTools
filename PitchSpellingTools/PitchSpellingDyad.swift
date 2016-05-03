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

    private let lower: PitchSpelling
    private let higher: PitchSpelling

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
    
    /// Mean of `sharpness` values of both `PitchSpelling` objects.
    public var meanSharpness: Sharpness { return [lower.sharpness, higher.sharpness].mean! }
    
    /// Amount of steps between two `PitchSpelling` objects.
    public var steps: Int {
        return abs(Int.mod(higher.letterName.steps - lower.letterName.steps, 7))
    }

    /// `IntervalQuality` between `PitchSpelling` objects.
    public var intervalQuality: IntervalQualityKind {
        let family = IntervalQuality.intervalFamily(withAmountOfSteps: steps)
        return family.kind(lower.coarse, higher.coarse)
    }
    
    /**
     Create a `PitchSpellingDyad` with two `PitchSpelling` objects.
     */
    public init(_ lower: PitchSpelling, _ higher: PitchSpelling) {
        self.lower = lower
        self.higher = higher
    }
}
