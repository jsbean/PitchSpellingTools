//
//  PitchSetSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/17/16.
//
//

import ArrayTools
import Pitch

/**
 Spells `PitchSet` values.
 */
public struct PitchSetSpeller: PitchSpeller {
    
    private static func makeSortedDyads(fromDyads dyads: [Dyad]) -> [Dyad] {
        return dyads
            .filter { $0.interval.complexity != nil }
            .sort { $0.interval.complexity! < $1.interval.complexity! }
    }
    
    public let dyads: [Dyad]
    private let pitchSet: PitchSet
    
    // sort dyads by spelling complexity
    
    public init(_ pitchSet: PitchSet) {
        self.pitchSet = pitchSet
        self.dyads = PitchSetSpeller.makeSortedDyads(fromDyads: pitchSet.dyads)
    }
}
