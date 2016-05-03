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

    public var isCoarseMatching: Bool { return lower.coarse == higher.coarse }
    
    public var isCoarseDirectionMatching: Bool {
        return lower.coarse.direction == higher.coarse.direction
    }
    
    public var isFineMatching: Bool { return lower.fine == higher.fine }
    
    public var meanSharpness: Sharpness { return [lower.sharpness, higher.sharpness].mean! }
    
    public var steps: Int {
        return abs(Int.mod(higher.letterName.steps - lower.letterName.steps, 7))
    }

    public var intervalQuality: IntervalQualityKind {
        let family = IntervalQuality.intervalFamily(withAmountOfSteps: steps)
        return family.kind(lower.coarse, higher.coarse)
    }
    
    public init(_ lower: PitchSpelling, _ higher: PitchSpelling) {
        self.lower = lower
        self.higher = higher
    }
}
