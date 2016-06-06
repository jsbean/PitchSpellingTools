//
//  SemiAmbiguousPitchSpellingRanker.swift
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
final class SemiAmbiguousPitchSpellingRanker: PitchSpellingRanking {
    
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
    
    func applyRankings(withAmount amount: Float) {
        edges.forEach { penalizeIfNecessary(edge: $0, withAmount: amount) }
    }
    
    private func penalizeIfNecessary(edge edge: PitchSpellingEdge, withAmount amount: Float) {
        ensureIsRanked(edge: edge)
        for rule in rules where !rule(edge.pitchSpellingDyad) {
            penalize(edge: edge, byAmount: amount)
        }
    }
    
    private func penalize(edge edge: PitchSpellingEdge, byAmount amount: Float) {
        penalize(node: edge.b, byAmount: amount)
    }
    
    private func penalize(node node: PitchSpellingNode, byAmount amount: Float) {
        node.rank! -= amount
    }
    
    private func ensureIsRanked(edge edge: PitchSpellingEdge) {
        [edge.a, edge.b].forEach { ensureIsRanked(node: $0) }
    }
    
    private func ensureIsRanked(node node: PitchSpellingNode) {
        if node.rank == nil { node.rank = 1 }
    }
}

extension SemiAmbiguousPitchSpellingRanker {
    
    var description: String {
        var result = "SemiAmbiguousPitchSpellingRanker:\n"
        result += "- PitchSpellingNode: \(determinate)\n"
        result += "- Level: \(other)\n"
        result += "Edges: "
        edges.forEach { result += "\n- \($0)" }
        return result
    }
}