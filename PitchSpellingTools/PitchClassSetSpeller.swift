//
//  PitchClassSetSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/24/16.
//
//

import ArrayTools
import Pitch

/**
 - TODO: Nest this within `PitchClassSetSpeller`.
 */
enum RuleScope {
    case node, edge, graph
}

public typealias Cost = Float

typealias Node = PitchSpelling
typealias Edge = (PitchSpelling, PitchSpelling)
typealias Graph = [PitchSpelling]

/// - TODO: Nest these within `PitchClassSetSpeller`
/// - TODO: In Swift 3.0, Generic Typealiases are allowed.
/// - Use SpellingRule<Input> = (costMultipler: Float) -> (Input) -> ()
typealias NodeRule = (_ costMultiplier: Float) -> (Node) -> Cost
typealias EdgeRule = (_ costMultiplier: Float) -> (Edge) -> Cost
typealias GraphRule = (_ costMultiplier: Float) -> (Graph) -> Cost

// Node rules
let doubleSharpOrDoubleFlat: NodeRule = { costMultiplier in
    return { node in
        if abs(node.quarterStep.rawValue) < 1 { return 1.0 }
        return 0
    }
}

//let threeQuarterSharpOrThreeQuarterFlat: NodeRule = { costMultiplier in
//    return { node in
//        /* TODO */
//        return 0
//    }
//}

let badEnharmonic: NodeRule = { costMultiplier in
    return { node in
        switch (node.letterName, node.quarterStep) {
        case (.b, .sharp), (.e, .sharp), (.c, .flat), (.f, .flat): return 1 * costMultiplier
        default: return 0
        }
    }
}

let quarterStepEighthStepCombination: NodeRule = { costMultiplier in
    return { node in
        /* TODO */
        return 0
    }
}

// Edge rules
let unison: EdgeRule = { costMultitplier in
    return { edge in
        /* TODO */
        return 0
    }
}

let augmentedOrDiminished: EdgeRule = { costMultiplier in
    return { edge in
        /* TODO */
        return 0
    }
}

let crossover: EdgeRule = { costMultiplier in
    return { edge in
        /* TODO */
        return 0
    }
}

let flatSharpIncompatibility: EdgeRule = { costMultiplier in
    return { edge in
        /* TODO */
        return 0
    }
}

// Graph rules
let eighthStepDirectionIncompatibility: GraphRule = { costMultiplier in
    return { graph in
        /* TODO */
        return 0
    }
}

// TODO: initialize PitchClassSetSpeller with rules and costMultipliers
let nodeRules: [(Node) -> Float] = [
    doubleSharpOrDoubleFlat(1.0),
    badEnharmonic(1.0),
    quarterStepEighthStepCombination(1.0)
    //threeQuarterSharpOrThreeQuarterFlat(costMultiplier: 1.0),
]

let edgeRules: [(Edge) -> Float] = [
    unison(1.0),
    augmentedOrDiminished(1.0),
    crossover(1.0),
    flatSharpIncompatibility(1.0)
]

let graphRules: [(Graph) -> Float] = [
    eighthStepDirectionIncompatibility(1.0)
]

func cost<A>(_ a: A, _ rules: [(A) -> Float]) -> Float {
    return rules.reduce(0) { accum, rule in accum + rule(a) }
}

func cost(_ a: Node, _ graph: Graph, _ rules: [(Edge) -> Float]) -> Float {
    return graph.reduce(0) { accum, b in accum + cost((a,b), rules) }
}

public struct PitchClassSetSpeller {

    fileprivate let costThreshold: Float
    fileprivate var bestGraphs: [Graph] = []
    
    fileprivate let pitchClassSet: PitchClassSet
    
    // make an optional init for rules
    public init(_ pitchClassSet: PitchClassSet, costThreshold: Cost = 100) {
        self.pitchClassSet = pitchClassSet
        self.costThreshold = costThreshold
    }
    
    public func spell() -> SpelledPitchClassSet {
 
        struct SpellingContext {
            let spelling: PitchSpelling
            let totalCost: Cost
            let nodeEdgeCost: Cost
        }
        
        var spellingContexts: [SpellingContext] = []
        
        func traverseToSpell(
            _ pitchClasses: [PitchClass],
            graph: [PitchSpelling],
            accumCost: Cost,
            nodeEdgeCost: Cost
        ) -> SpelledPitchClassSet
        {
            guard let (pitchClass, remaining) = pitchClasses.destructured else {
                return SpelledPitchClassSet()
            }
            
            // spellingContext could be made with a flatMap on `pitchClass.spellings`?
            for spelling in pitchClass.spellings {
                
                print("spelling: \(spelling) ------------------------------------------------")
                
                var spellingCost: Float = accumCost
                
                // TODO: consider best way to struct this flow
                // - i.e., the return type of each of these wrapping functions
                // - e.g., (Spelling, (Spelling) -> Float, maxThreshold: Float) -> Float?
                // - if `nil`, threshold crossed 
                
                // node
                let nodeCost = cost(spelling, nodeRules)
                spellingCost += nodeCost
                
                guard spellingCost < costThreshold else { fatalError() } // todo
                
                // edge
                let edgeCost = cost(spelling, graph, edgeRules)
                spellingCost += edgeCost
                
                guard spellingCost < costThreshold else { fatalError() } // todo
                
                // temporary graph
                var tempGraph = graph
                tempGraph.append(spelling)
                let graphCost = cost(tempGraph, graphRules)
                spellingCost += graphCost
                
                guard spellingCost < costThreshold else { fatalError() } // todo
                
                let spellingContext = SpellingContext(
                    spelling: spelling,
                    totalCost: spellingCost,
                    nodeEdgeCost: nodeCost + edgeCost
                )
                
                spellingContexts.append(spellingContext)
                tempGraph.removeLast()
            }
            
            guard !spellingContexts.isEmpty else { fatalError() } // todo
            
            for spellingContext in spellingContexts.sorted(by: { $0.totalCost < $1.totalCost }) {
                if spellingContext.totalCost < costThreshold {
                    let nodeEdgeCost = spellingContext.nodeEdgeCost + nodeEdgeCost
                    var graph = graph
                    graph.append(spellingContext.spelling)
                    return traverseToSpell(
                        remaining,
                        graph: graph,
                        accumCost: accumCost,
                        nodeEdgeCost: nodeEdgeCost
                    )
                } else {
                    fatalError()
                    // bail
                }
            }

            fatalError()
        }
        
        let pitchClasses = Array(pitchClassSet)
        return traverseToSpell(pitchClasses, graph: [], accumCost: 0, nodeEdgeCost: 0)
    }
}
