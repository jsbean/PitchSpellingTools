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
        
        // refactor
        // refine where to put the abs(steps)
        
        let steps = (higher.letterName.steps - lower.letterName.steps) % 7
        
        // gets the specific subclass IntervalFamily for the amount of steps
        let family = IntervalQuality.intervalFamily(withAmountOfSteps: steps)
        
        // gets the specific quality static let property
        let qualityKind = family.kind(lower.coarse, higher.coarse)
        
        return qualityKind
    }
    
    public init(_ lower: PitchSpelling, _ higher: PitchSpelling) {
        self.lower = lower
        self.higher = higher
    }
}
