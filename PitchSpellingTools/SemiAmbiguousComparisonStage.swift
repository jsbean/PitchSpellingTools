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
    
    let determinate: PitchSpellingNode
    let other: Level
    
    // NOTE: `PitchSpellingEdge.b` is the unspelled `PitchSpellingNode`.
    lazy var edges: [PitchSpellingEdge] = {
        return self.other.nodes.map { PitchSpellingEdge(self.determinate, $0) }
    }()
    
    var highestRanked: PitchSpellingNode? { return other.highestRanked }
    
    init(determinate: PitchSpellingNode, other: Level) {
        self.determinate = determinate
        self.other = other
        determinate.rank = 1
    }
    
    func applyRankings(withWeight weight: Float) {
        edges.forEach { penalizeIfNecessary(edge: $0, withWeight: weight) }
    }
    
    private func penalizeIfNecessary(edge edge: PitchSpellingEdge, withWeight weight: Float) {
        ensureIsRanked(edge: edge)
        for rule in rules where !rule(edge.pitchSpellingDyad) {
            penalize(edge: edge, withWeight: weight)
        }
    }
    
    private func penalize(edge edge: PitchSpellingEdge, withWeight weight: Float) {
        penalize(node: edge.b, withWeight: weight)
    }
    
    private func penalize(node node: PitchSpellingNode, withWeight weight: Float) {
        node.rank! -= weight
    }
    
    private func ensureIsRanked(edge edge: PitchSpellingEdge) {
        [edge.a, edge.b].forEach { ensureIsRanked(node: $0) }
    }
    
    private func ensureIsRanked(node node: PitchSpellingNode) {
        if node.rank == nil { node.rank = 1 }
    }
}

extension SemiAmbiguousComparisonStage {
    
    var description: String {
        var result = "SemiAmbiguousComparisonStage:\n"
        result += "- PitchSpellingNode: \(determinate)\n"
        result += "- Level: \(other)\n"
        result += "Edges: "
        edges.forEach { result += "\n- \($0)" }
        return result
    }
}