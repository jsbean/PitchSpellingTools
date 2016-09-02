//
//  PitchClassSetSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 8/24/16.
//
//

import ArrayTools
import Pitch

// MARK: - Typealiases

/// Single `PitchSpelling` value.
typealias Node = PitchSpelling

/// Pair of `PitchSpelling` values.
typealias Edge = (PitchSpelling, PitchSpelling)

/// All `PitchSpelling` values comprising a graph.
typealias Graph = [PitchSpelling]

/// Defintion of a spelling rule that takes a cost multiplier and an input, returning a cost.
///
/// The cost multiplier can be used within the closure to worsen the penalty depending on 
/// more or less egregious offences.
///
/// The `Input` can be any of the following:
/// - `Node` (aka `PitchSpelling`)
/// - `Edge` (aka `(PitchSpelling, PitchSpelling)`)
/// - `Graph` (aka `[PitchSpelling]`)
typealias Rule<Input> = (Float) -> (Input) -> Float

// MARK: - Node-level rules

let doubleSharpOrDoubleFlat: Rule<Node> = { costMultiplier in
    return { spelling in abs(spelling.quarterStep.rawValue) == 2 ? 1 : 0 }
}

let threeQuarterSharpOrThreeQuarterFlat: Rule<Node> = { costMultiplier in
    return { spelling in abs(spelling.quarterStep.rawValue) == 1.5 ? 1 : 0 }
}

let badEnharmonic: Rule<Node> = { costMultiplier in
    return { spelling in
        switch (spelling.letterName, spelling.quarterStep) {
        case (.b, .sharp), (.e, .sharp), (.c, .flat), (.f, .flat): return 1 * costMultiplier
        default: return 0
        }
    }
}

let quarterStepEighthStepCombination: Rule<Node> = { costMultiplier in
    return { spelling in
        switch (spelling.quarterStep.resolution, abs(spelling.eighthStep.rawValue)) {
        case (.quarterStep, 0.25): return 1
        default: return 0
        }
    }
}

// MARK: - Edge-level rules

let unison: Rule<Edge> = { costMultiplier in
    return { (a,b) in a.letterName == b.letterName ? 1 : 0 }
}

let augmentedOrDiminished: Rule<Edge> = { costMultiplier in
    return { (a,b) in
        switch NamedInterval(a,b).quality {
        case NamedInterval.Quality.augmented, NamedInterval.Quality.diminished: return 1
        default: return 0
        }
    }
}

let crossover: Rule<Edge> = { costMultiplier in
    return { (a,b) in
        return (a.letterName.steps < b.letterName.steps) != (a.pitchClass < b.pitchClass)
            ? 1
            : 0
    }
}

/// - TODO: Consider merging this into augmented / diminished
let flatSharpIncompatibility: Rule<Edge> = { costMultiplier in
    return { (a,b) in
        return a.quarterStep.direction.rawValue * b.quarterStep.direction.rawValue == -1
            ? 1
            : 0
    }
}

// MARK: - Graph-level rules

let eighthStepDirectionIncompatibility: Rule<Graph> = { costMultiplier in
    return { graph in
        for ai in graph.indices {
            let a = graph[ai]
            for bi in ai + 1 ..< graph.endIndex {
                let b = graph[bi]
                switch (a.eighthStep.rawValue, b.eighthStep.rawValue) {
                case (0, _), (_, 0), (-0.25, -0.25), (0.25, 0.25): break
                default: return 1
                }
            }
        }
        return 0
    }
}

// MARK: - Rule collections

let nodeRules: [(Node) -> Float] = [
    doubleSharpOrDoubleFlat(1),
    badEnharmonic(1),
    quarterStepEighthStepCombination(1),
    threeQuarterSharpOrThreeQuarterFlat(1),
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

// MARK: - Cost functions

func cost<A>(_ a: A, _ rules: [(A) -> Float]) -> Float {
    return rules.reduce(0) { $0 + $1(a) }
}

func cost(_ a: Node, _ graph: Graph, _ rules: [(Edge) -> Float]) -> Float {
    return graph.reduce(0) { $0 + cost((a,$1), rules) }
}

public struct PitchClassSetSpeller {

    private let costThreshold: Float
    private var bestGraphs: [Graph] = []
    private let pitchClassSet: PitchClassSet
    
    // make an optional init for rules
    public init(_ pitchClassSet: PitchClassSet, costThreshold: Float = 100) {
        self.pitchClassSet = pitchClassSet
        self.costThreshold = costThreshold
    }
    
    public func spell() -> SpelledPitchClassSet {
        
        struct SpellingContext {
            let spelling: PitchSpelling
            let totalCost: Float
            let nodeEdgeCost: Float
        }
        
        var spellingContexts: [SpellingContext] = []
        
        func traverseToSpell(
            _ pitchClasses: [PitchClass],
            graph: Graph,
            accumCost: Float,
            nodeEdgeCost: Float
        ) -> SpelledPitchClassSet
        {
            guard let (pitchClass, remaining) = pitchClasses.destructured else {
                return SpelledPitchClassSet()
            }
            
            for spelling in pitchClass.spellings {
                
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
                
                guard spellingCost < costThreshold else {
                    fatalError()
                }
                
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
