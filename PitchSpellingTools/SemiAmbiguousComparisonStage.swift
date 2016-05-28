//
//  SemiAmbiguousComparisonStage.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import Foundation

/**
 Compares the spelling of `Pitch` that can be spelled objectively (a `natural`) with all of the
 potential spellings of a `Pitch` that cannot be spelled objectively for the purpose of 
 ranking.
 
 This structure ranks the individual potential `PitchSpelling` objects for the ambiguously
 spellable `Pitch`.
 
       o    = determinate
      / \   = edges
     -----
    | o o | = other
     -----
 */
final class SemiAmbiguousComparisonStage: ComparisonStage {
 
    let determinate: Node
    let other: Level
    
    // NOTE: `Edge.b` is the unspelled `Node`.
    lazy var edges: [Edge] = {
        return self.other.nodes.map { Edge(self.determinate, $0) }
    }()
    
    init(determinate: Node, other: Level) {
        self.determinate = determinate
        self.other = other
        determinate.rank = 1
    }
    
    func rate(withWeight weight: Float) {
        for edge in edges {
            print("edge.psDyad: \(edge.pitchSpellingDyad)")
            if edge.b.rank == nil { edge.b.rank = 1 }
            if (
                !edge.pitchSpellingDyad.isFineCompatible ||
                !edge.pitchSpellingDyad.isStepPreserving
            )
            {
                print("breaks rules; penalize: weight: \(weight)")
                edge.b.rank! -= weight
            }
        }
        print("edges: \(edges)")
    }
}
