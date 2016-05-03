//
//  PitchSpellingDyad.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/2/16.
//
//

import ArithmeticTools

public struct PitchSpellingDyad {
    
    private let lower: PitchSpelling
    private let higher: PitchSpelling
    
    public var isCoarseMatching: Bool { return lower.coarse == higher.coarse }
    
    public var isCoarseDirectionMatching: Bool {
        return lower.coarse.direction == higher.coarse.direction
    }
    
    public var isFineMatching: Bool { return lower.fine == higher.fine }
    
    public var meanSharpness: Sharpness { return [lower.sharpness, higher.sharpness].mean! }

    public var intervalQuality: IntervalQualityKind {
        // get steps
        let steps = (higher.letterName.steps - lower.letterName.steps) % 7
        
        
        
        
        //let family = IntervalQuality.intervalFamily(withAmountOfSteps: steps)
        return IntervalQuality.Unison.Perfect
        //return .PerfectUnison
    }
    
    public init(_ lower: PitchSpelling, _ higher: PitchSpelling) {
        self.lower = lower
        self.higher = higher
    }
}
