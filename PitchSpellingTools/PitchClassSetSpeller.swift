//
//  PitchClassSetSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/24/16.
//
//

import ArrayTools
import Pitch

typealias Node = PitchSpelling
typealias Edge = (PitchSpelling, PitchSpelling)
typealias Graph = [PitchSpelling]

typealias Rule<Input> = (Float) -> (Input) -> Float

// Node rules
let doubleSharpOrDoubleFlat: Rule<Node> = { costMultiplier in
    print("double sharp or double flat")
    return { node in abs(node.quarterStep.rawValue) < 1 ? 1 : 0 }
}

//let threeQuarterSharpOrThreeQuarterFlat: Rule<Node> = { costMultiplier in
//    return { node in
//        /* TODO */
//        return 0
//    }
//}

let badEnharmonic: Rule<Node> = { costMultiplier in
    print("bad harmonic")
    return { node in
        switch (node.letterName, node.quarterStep) {
        case (.b, .sharp), (.e, .sharp), (.c, .flat), (.f, .flat): return 1 * costMultiplier
        default: return 0
        }
    }
}

let quarterStepEighthStepCombination: Rule<Node> = { costMultiplier in
    print("quarter step / eighth step")
    return { node in
        /* TODO */
        return 0
    }
}

// Edge rules
let unison: Rule<Edge> = { costMultitplier in
    print("unison")
    return { (a,b) in a.letterName == b.letterName ? 0 : 1 }
}

let augmentedOrDiminished: Rule<Edge> = { costMultiplier in
    print("augmented or diminished")
    return { (a,b) in
        switch NamedInterval(a,b).quality {
        case NamedInterval.Quality.augmented, NamedInterval.Quality.diminished: return 1
        default: return 0
        }
    }
}

let crossover: Rule<Edge> = { costMultiplier in
    return { edge in
        /* TODO */
        return 0
    }
}

let flatSharpIncompatibility: Rule<Edge> = { costMultiplier in
    return { edge in
        /* TODO */
        return 0
    }
}

// Graph rules
let eighthStepDirectionIncompatibility: Rule<Graph> = { costMultiplier in
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
    return rules.reduce(0) {
        accum, rule in
        let cost = rule(a)
        print("input: \(a); cost: \(cost)")
        return accum + cost
    }
}

func cost(_ a: Node, _ graph: Graph, _ rules: [(Edge) -> Float]) -> Float {
    return graph.reduce(0) { accum, b in accum + cost((a,b), rules) }
}

public struct PitchClassSetSpeller {

    fileprivate let costThreshold: Float
    fileprivate var bestGraphs: [Graph] = []
    
    fileprivate let pitchClassSet: PitchClassSet
    
    // make an optional init for rules
    public init(_ pitchClassSet: PitchClassSet, costThreshold: Float = 100) {
        self.pitchClassSet = pitchClassSet
        self.costThreshold = costThreshold
    }
    
    public func spell() -> SpelledPitchClassSet {
 
        print("spelling \(pitchClassSet); not to exceed: \(costThreshold)")
        
        struct SpellingContext {
            let spelling: PitchSpelling
            let totalCost: Float
            let nodeEdgeCost: Float
        }
        
        var spellingContexts: [SpellingContext] = []
        
        func traverseToSpell(
            _ pitchClasses: [PitchClass],
            graph: [PitchSpelling],
            accumCost: Float,
            nodeEdgeCost: Float
        ) -> SpelledPitchClassSet
        {
            guard let (pitchClass, remaining) = pitchClasses.destructured else {
                return SpelledPitchClassSet()
            }
            
            print("pitch class: \(pitchClass)")
            
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
                print("node cost: \(nodeCost)")
                spellingCost += nodeCost
                
                guard spellingCost < costThreshold else { fatalError() } // todo
                
                // edge
                let edgeCost = cost(spelling, graph, edgeRules)
                print("edge cost: \(edgeCost)")
                spellingCost += edgeCost
                
                guard spellingCost < costThreshold else {
                    print("spelling cost has passed threshold!")
                    fatalError()
                }
                
                // temporary graph
                var tempGraph = graph
                tempGraph.append(spelling)
                let graphCost = cost(tempGraph, graphRules)
                print("graph cost: \(graphCost)")
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
            
            for context in spellingContexts.sorted(by: { $0.totalCost < $1.totalCost }) {
                if context.totalCost < costThreshold {
                    let nodeEdgeCost = context.nodeEdgeCost + nodeEdgeCost
                    var graph = graph
                    graph.append(context.spelling)
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
