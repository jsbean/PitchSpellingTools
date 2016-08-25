//
//  PitchClassSetSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/24/16.
//
//

import ArrayTools
import Pitch

/// - warning: This is a stub class.
/// - TODO: Inherit from real version in `GraphStructures`.
public class Node {
    let spelledPitch: SpelledPitch
    init(spelledPitch: SpelledPitch) {
        self.spelledPitch = spelledPitch
    }
}

/// - warning: This is a stub class.
/// - TODO: Inherit from real version in `GraphStructures`.
public class Edge {
    let nodes: (Node, Node)
    init(nodes: (Node, Node)) {
        self.nodes = nodes
    }
}

/// - warning: This is a stub class.
/// - TODO: Inherit from real version in `GraphStructures`.
public class Graph {
    var edges: [Edge] = []
    var nodes: [Node] = []
    init() { }
}

/**
 - TODO: Nest this within `PitchClassSetSpeller`.
 */
enum RuleScope {
    case node, edge, graph
}

/// - TODO: Nest these within `PitchClassSetSpeller`
/// - TODO: In Swift 3.0, Generic Typealiases are allowed.
/// - Use SpellingRule<Int> = Input, Float -> ()
typealias NodeRule = (Node, Float) -> ()
typealias EdgeRule = (Edge, Float) -> ()
typealias GraphRule = (Graph, Float) -> ()

// Node rules
let doubleSharpOrDoubleFlat: NodeRule = { node, costMultiplier in /* TODO */ }
let threeQuarterSharpOrThreeQuarterFlat: NodeRule = { node, costMultiplier in /* TODO */ }
let badEnharmonic: NodeRule = { node, costMultiplier in /* TODO */ }
let quarterStepEighthStepCombination: NodeRule = { node, costMultiplier in /* TODO */ }

// Edge rules
let unison: EdgeRule = { edge, costMultiplier in /* TODO */ }
let augmentedOrDiminished: EdgeRule = { edge, costMultiplier in /* TODO */ }
let crossover: EdgeRule = { edge, costMultiplier in /* TODO */ }
let flatSharpMixture: EdgeRule = { edge, costMultiplier in /* TODO */ }

// Graph rules
let eighthStepDirectionIncompatibility: GraphRule = { graph, costMultiplier in /* TODO */ }

public struct PitchClassSetSpeller {
    
    public typealias Cost = Float
    
    // MARK: - Rules
    static let nodeRules: [NodeRule] = [
        doubleSharpOrDoubleFlat,
        threeQuarterSharpOrThreeQuarterFlat,
        badEnharmonic,
        quarterStepEighthStepCombination
    ]
    
    static let edgeRules: [EdgeRule] = [
        unison,
        augmentedOrDiminished,
        crossover,
        flatSharpMixture
    ]
    
    static let graphRules: [GraphRule] = [
        eighthStepDirectionIncompatibility
    ]
    
    private let costThreshold: Float
    private var bestGraphs: [Graph] = []
    
    private let pitchClassSet: PitchClassSet
    
    // make an optional init for rules
    public init(pitchClassSet: PitchClassSet, costThreshold: Cost = 100) {
        self.pitchClassSet = pitchClassSet
        self.costThreshold = costThreshold
    }
    
    public func spell() -> SpelledPitchClassSet {
        
        func traverseToSpell(
            pitchClasses: [PitchClass],
            graph: Graph,
            accumCost: Cost,
            nodeEdgeCost: Cost
        ) -> SpelledPitchClassSet
        {
            
            // base case: all done
            guard let (currentPitch, tail) = pitchClasses.destructured else {
                // TODO
                fatalError()
            }
            
            let spellings = currentPitch.spellings
            
            traverseToSpell(tail, graph: graph, accumCost: accumCost, nodeEdgeCost: nodeEdgeCost)
            
            // TODO
            fatalError()
        }
        
        let pitchClasses = Array(pitchClassSet)
        return traverseToSpell(pitchClasses, graph: Graph(), accumCost: 0, nodeEdgeCost: 0)
    }
    
}
