//
//  ComparisonStage.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import Foundation

protocol ComparisonStage {
    
    var edges: [Edge] { get }
    
    var rules: [(PitchSpellingDyad) -> Bool] { get }
    
    func applyRankings(withWeight weight: Float)
    
    // TODO: apply rules
}

extension ComparisonStage {
    
    var rules: [(PitchSpellingDyad) -> Bool] {
        return [
            { $0.isFineCompatible },
            { $0.isStepPreserving },
            { $0.isCoarseResolutionCompatible },
            { $0.isCoarseDirectionCompatible }
        ]
    }
}