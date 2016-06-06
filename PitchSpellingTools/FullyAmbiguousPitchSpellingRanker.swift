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
 objectively, i.e., not `natural`, for purpose of ranking.
 
 This structure ranks the edges between potential `PitchSpelling` options, whereas
 the `SemiAmbiguousPitchSpellingRanker` ranks individual nodes.
 
 ```
     -----
    | o o | = a
     -----
     | X |  = edges
     -----
    | o o | = b
     -----
 ```
 */
public final class FullyAmbiguousPitchSpellingRanker: PitchSpellingRanking {
    
    private let a: Level
    private let b: Level
    
    /**
     All `PitchSpellingEdge` objects between each `PitchSpellingNode`
     in each `PitchSpellingEdge`
    */
    public lazy var edges: [PitchSpellingEdge] = {
        var result: [PitchSpellingEdge] = []
        for nodeA in self.a.nodes {
            for nodeB in self.b.nodes {
                result.append(PitchSpellingEdge(nodeA, nodeB))
            }
        }
        return result
    }()
    
    /// All of the `PitchSpellingEdge` objects with the highest rank.
    public var highestRankedEdges: [PitchSpellingEdge] {
        return edges.extremeElements(>) { $0.rank }
    }
    
    /**
     All of the `PitchSpellingEdge` objects that are highest ranked, 
     yet contain the lowest (or not-yet) ranked `PitchSpellingNode` objects.
    */
    public var almostGoodEnoughEdges: [PitchSpellingEdge] {
        return highestRankedEdges.extremeElements(<) { $0.meanRankOfNodes ?? Float.min }
    }
    
    /**
     The highest ranked `PitchSpellingEdge`, if there is at least one edge present.
     Otherwise, `nil`.
     */
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
    
    // MARK: - Initializers
    
    /**
     Create a `FullyAmbiguousPitchSpellingRanker` with two `PitchSpellingLevel` objects.
     */
    public init(_ a: Level, _ b: Level) {
        self.a = a
        self.b = b
    }
    
    // MARK: - Instance Methods
    
    /**
     Apply the rankings to all of the `PitchSpellingEdge` objects contained herein with the 
     given `amount`. 
     
     For each rule in `rules` broken by a given edge, that edge is penalized by the given
     `amount`.
     */
    public func applyRankings(withAmount amount: Float) {
        for edge in edges {
            for rule in rules where !rule(edge.pitchSpellingDyad) {
                penalize(edge: edge, byAmount: amount)
            }
        }
    }
    
    private func penalize(edge edge: PitchSpellingEdge, byAmount amount: Float) {
        edge.rank -= amount
    }
}

extension FullyAmbiguousPitchSpellingRanker {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        var result = "FullyAmbiguousPitchSpellingRanker:\n"
        result += "- Level1: \(a)\n"
        result += "- Level2: \(b)\n"
        result += "Edges: "
        edges.forEach { result += "\n- \($0)" }
        return result
    }
}
