//
//  FullyAmbiguousPitchSpellingRanker.swift
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
 the `SemiAmbiguousPitchSpellingRanker` ranks individual nodes.
 
     -----
    | o o | = a
     -----
     | X |  = edges
     -----
    | o o | = b
     -----
 */
public final class FullyAmbiguousPitchSpellingRanker: PitchSpellingRanking {
    
    /**
     One `PitchSpellingLevel` containing all possible `PitchSpellingNode` values available
     for a given `Pitch`.
     */
    public let a: Level
    
    /**
     The other `PitchSpellingLevel` containing all possible `PitchSpellingNode` values
     available for a given `Pitch`.
     */
    public let b: Level
    
    public lazy var edges: [PitchSpellingEdge] = {
        var result: [PitchSpellingEdge] = []
        for nodeA in self.a.nodes {
            for nodeB in self.b.nodes {
                result.append(PitchSpellingEdge(nodeA, nodeB))
            }
        }
        return result
    }()
    
    
    public var highestRankedEdges: [PitchSpellingEdge] {
        return edges.extremeElements(>) { $0.rank }
    }
    
    // TODO: update name
    public var almostGoodEnoughEdges: [PitchSpellingEdge] {
        return highestRankedEdges.extremeElements(<) { $0.meanRankOfNodes ?? Float.min }
    }
    
    // TODO: mention complexity
    var highestRanked: PitchSpellingEdge? {
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
    }
    
    public init(_ a: Level, _ b: Level) {
        self.a = a
        self.b = b
    }
    
    public func hasNode(node: PitchSpellingNode) -> Bool {
        return a === node || b === node
    }
    
    public func applyRankings(withWeight weight: Float) {
        for edge in edges {
            for rule in rules where !rule(edge.pitchSpellingDyad) {
                penalize(edge: edge, withWeight: weight)
            }
        }
    }
    
    private func penalize(edge edge: PitchSpellingEdge, withWeight weight: Float) {
        edge.rank -= weight
    }
}

extension FullyAmbiguousPitchSpellingRanker {
    
    public var description: String {
        var result = "FullyAmbiguousPitchSpellingRanker:\n"
        result += "- Level1: \(a)\n"
        result += "- Level2: \(b)\n"
        result += "Edges: "
        edges.forEach { result += "\n- \($0)" }
        return result
    }
}
