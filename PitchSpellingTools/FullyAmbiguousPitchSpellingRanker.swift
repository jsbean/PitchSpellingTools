//
//  FullyAmbiguousPitchSpellingRanker.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/27/16.
//
//

import ArithmeticTools
import ArrayTools

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
    
    // MARK: - Instance Properties
    
    private let a: PitchSpellingStack
    private let b: PitchSpellingStack
    
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
     
     - warning: This is very problematic.
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
    public init(_ a: PitchSpellingStack, _ b: PitchSpellingStack) {
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
        
        // test: mega penalize all edges with fine incompatibility
        for edge in edges {
            if !edge.pitchSpellingDyad.isFineCompatible {
                penalize(edge: edge, byAmount: 2)
                
            }
            
            if !edge.pitchSpellingDyad.hasValidIntervalQuality {
                penalize(edge: edge, byAmount: 1)
            }
        }
        
//        for edge in edges {
//            for (r, rule) in rules.enumerate() where !rule(edge.pitchSpellingDyad) {
//                
//                let adjustment = Float(rules.count - r) / Float(rules.count)
//                let adjustedAmount = adjustment * amount
////                print("amount: \(amount); adjustment: \(adjustment); adjustedAmount: \(adjustedAmount)")
//                penalize(edge: edge, byAmount: adjustedAmount)
//            }
//        }
        print("all edges:")
        edges.forEach { print($0) }
        print("highest ranked edges: ")
        highestRankedEdges.forEach { print($0) }
        print("almost good enough edges: ")
        almostGoodEnoughEdges.forEach { print($0) }
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
