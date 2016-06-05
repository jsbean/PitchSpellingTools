//
//  FullyAmbiguousComparisonStage.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import ArithmeticTools

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
    
    // TODO: mention complexity
    var highestRanked: Edge? {
        return edges
            .stableSort {
                $0.pitchSpellingDyad.meanSpellingDistance <
                $1.pitchSpellingDyad.meanSpellingDistance
            }
            .stableSort {
                $0.pitchSpellingDyad.meanCoarseDistance <
                $1.pitchSpellingDyad.meanCoarseDistance
            }
            .stableSort { $0.rank > $1.rank }
            .first


//            .stableSort { $0.rank > $1.rank }
//            .first
    }
    
    init(_ a: Level, _ b: Level) {
        self.a = a
        self.b = b
    }
    
    func hasNode(node: Node) -> Bool {
        return a === node || b === node
    }
    
    func applyRankings(withWeight weight: Float) {
        for edge in edges {
            for rule in rules where !rule(edge.pitchSpellingDyad) {
                penalize(edge: edge, withWeight: weight)
            }
        }
    }
    
    private func penalize(edge edge: Edge, withWeight weight: Float) {
        edge.rank -= weight
    }
}

extension FullyAmbiguousComparisonStage {
    
    var description: String {
        var result = "FullyAmbiguousComparisonStage:\n"
        result += "- Level1: \(a)\n"
        result += "- Level2: \(b)\n"
        result += "Edges: "
        edges.forEach { result += "\n- \($0)" }
        return result
    }
}
