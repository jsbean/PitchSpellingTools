//
//  FullyAmbiguousComparisonStage.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import Foundation

/**
 Compares all of the potential spellings of two `Pitch` objects that cannot be spelled
 objectively, i.e., not `natural` for purpose of ranking.
 
 This structure ranks the relationships between potential `PitchSpelling` options, whereas
 the `SemiAmbiguousComparisonStage` ranks individual nodes.
 
     -----
    | o o | = a
     -----
     | X |  = edges
     -----
    | o o | = b
     -----
 
 - TODO: Consider getting rid of `Level` and just using `[Node]`
 */
final class FullyAmbiguousComparisonStage: ComparisonStage {
    
    let a: Level
    let b: Level
    
    lazy var edges: [Edge] = {
        var result: [Edge] = []
        for nodeA in self.a.nodes {
            for nodeB in self.b.nodes {
                result.append(Edge(nodeA, nodeB))
            }
        }
        return result
    }()
    
    init(_ a: Level, _ b: Level) {
        self.a = a
        self.b = b
    }
    
    func applyRankings(withWeight weight: Float) {
        ensureEdgesHaveRankings()
        for edge in edges {
            for rule in rules {
                if !rule(edge.pitchSpellingDyad) {
                    penalize(edge: edge, withWeight: weight)
                }
            }
        }
        
        // filter out all but the highest ranking -- these were disqualified
        let highestRank = edges.sort { $0.rank! > $1.rank! }.first!.rank!
        edges = edges.filter { $0.rank! == highestRank }
        
        // todo modify rank based on mean spelling distance
        edges = edges.sort {
            $0.pitchSpellingDyad.meanSpellingDistance <
            $1.pitchSpellingDyad.meanSpellingDistance
        }
        print("edges: \(edges)")
    }
    
    private func penalize(edge edge: Edge, withWeight weight: Float) {
        edge.rank! -= weight
    }
    
    private func ensureEdgesHaveRankings() {
        edges.forEach { if $0.rank == nil { $0.rank = 1 } }
    }
}