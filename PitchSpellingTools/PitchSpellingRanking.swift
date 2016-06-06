//
//  PitchSpellingRanking.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import Foundation

/**
 Interface for types that rank `PitchSpellingNode` and `PitchSpellingEdge` objects.
 */
public protocol PitchSpellingRanking: CustomStringConvertible {
    
    var edges: [PitchSpellingEdge] { get }
    var rules: [(PitchSpellingDyad) -> Bool] { get }
    
    func applyRankings(withWeight weight: Float)
}

extension PitchSpellingRanking {
    
    public var rules: [(PitchSpellingDyad) -> Bool] {
        return [
            { $0.isFineCompatible },
            { $0.hasValidIntervalQuality },
            { $0.isCoarseResolutionCompatible },
            { $0.isCoarseDirectionCompatible }
        ]
    }
}
