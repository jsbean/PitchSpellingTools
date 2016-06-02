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
    
    func applyRankings(withWeight weight: Float) {
        edges.forEach { penalizeIfNecessary(edge: $0, withWeight: weight) }
    }
    
    private func penalizeIfNecessary(edge edge: Edge, withWeight weight: Float) {
        ensureIsRanked(edge: edge)
        for rule in rules where !rule(edge.pitchSpellingDyad) {
            penalize(edge: edge, withWeight: weight)
        }
    }
    
    private func penalize(edge edge: Edge, withWeight weight: Float) {
        penalize(node: edge.b, withWeight: weight)
    }
    
    private func penalize(node node: Node, withWeight weight: Float) {
        node.rank! -= weight
    }
    
    private func ensureIsRanked(edge edge: Edge) {
        [edge.a, edge.b].forEach { ensureIsRanked(node: $0) }
    }
    
    private func ensureIsRanked(node node: Node) {
        if node.rank == nil { node.rank = 1 }
    }
}

extension SemiAmbiguousComparisonStage {
    
    var description: String {
        var result = "SemiAmbiguousComparisonStage:\n"
        result += "- \(determinate)\n"
        result += "- \(other)\n"
        result += "Edges: "
        edges.forEach { result += "\n- \($0)" }
        return result
    }
}