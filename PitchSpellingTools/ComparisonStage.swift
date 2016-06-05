//
//  ComparisonStage.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import Foundation

protocol ComparisonStage: CustomStringConvertible {
    
    var edges: [PitchSpellingEdge] { get }
    var rules: [(PitchSpellingDyad) -> Bool] { get }
    
    func applyRankings(withWeight weight: Float)
}

extension ComparisonStage {
    
    var rules: [(PitchSpellingDyad) -> Bool] {
        return [
            { $0.isFineCompatible },
            { $0.hasIntervalFidelity },
            { $0.isCoarseResolutionCompatible },
            { $0.isCoarseDirectionCompatible }
        ]
    }
}
