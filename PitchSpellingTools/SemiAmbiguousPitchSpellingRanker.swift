////
////  SemiAmbiguousPitchSpellingRanker.swift
////  PitchSpellingTools
////
////  Created by James Bean on 5/27/16.
////
////
//
///**
// Compares the spelling of `Pitch` that can be spelled objectively (a `natural`) with all of the
// potential spellings of a `Pitch` that cannot be spelled objectively for the purpose of 
// ranking.
// 
// This structure ranks the individual potential `PitchSpelling` objects for the ambiguously
// spellable `Pitch`.
// 
// ```
//       o    = objectively spellable
//      / \   = edges
//     -----
//    | o o | = ambiguously spellable
//     -----
// ```
// */
//public final class SemiAmbiguousPitchSpellingRanker: PitchSpellingRanking {
//    
//    private let objectivelySpellable: PitchSpellingNode
//    private let ambiguouslySpellable: PitchSpellingStack
//    
//    // NOTE: `PitchSpellingEdge.b` is the unspelled `PitchSpellingNode`.
//    public lazy var edges: [PitchSpellingEdge] = {
//        return self.ambiguouslySpellable.nodes.map {
//            PitchSpellingEdge(self.objectivelySpellable, $0)
//        }
//    }()
//    
//    /// Highest ranked `PitchSpellingNode` if available. Otherwise, `nil`.
//    var highestRanked: PitchSpellingNode? { return ambiguouslySpellable.highestRanked }
//    
//    // MARK: - Initializers
//    
//    /**
//     Create a `SemiAmbiguousPitchSpellingRanker` with an objectively-spellable 
//     `PitchSpellingNode` and an ambiguously spellable `PitchSpellingLevel` object.
//     */
//    public init(objectivelySpellable: PitchSpellingNode, ambiguouslySpellable: PitchSpellingStack) {
//        self.objectivelySpellable = objectivelySpellable
//        self.ambiguouslySpellable = ambiguouslySpellable
//        objectivelySpellable.rank = 1
//    }
//    
//    /**
//     Apply the rankings to all of the `PitchSpellingEdge` objects contained herein with the
//     given `amount`.
//     
//     For each rule in `rules` broken by a given edge, that edge is penalized by the given
//     `amount`.
//     */
//    public func applyRankings(withAmount amount: Float) {
//        edges.forEach { penalizeIfNecessary(edge: $0, withAmount: amount) }
//    }
//    
//    private func penalizeIfNecessary(edge edge: PitchSpellingEdge, withAmount amount: Float) {
//        ensureIsRanked(edge: edge)
//        for (r, rule) in rules.enumerate() where !rule(edge.pitchSpellingDyad) {
//            let adjustment = Float(rules.count - r) / Float(rules.count)
//            let adjustedAmount = adjustment * amount
//            penalize(edge: edge, byAmount: adjustedAmount)
//        }
//    }
//    
//    private func penalize(edge edge: PitchSpellingEdge, byAmount amount: Float) {
//        penalize(node: edge.b, byAmount: amount)
//    }
//    
//    private func penalize(node node: PitchSpellingNode, byAmount amount: Float) {
//        node.rank! -= amount
//    }
//    
//    private func ensureIsRanked(edge edge: PitchSpellingEdge) {
//        [edge.a, edge.b].forEach { ensureIsRanked(node: $0) }
//    }
//    
//    private func ensureIsRanked(node node: PitchSpellingNode) {
//        if node.rank == nil { node.rank = 1 }
//    }
//}
//
//extension SemiAmbiguousPitchSpellingRanker {
//    
//    // MARK: - CustomStringConvertible
//    
//    /// Printed description.
//    public var description: String {
//        var result = "SemiAmbiguousPitchSpellingRanker:\n"
//        result += "- Objectively-spellable Node: \(objectivelySpellable)\n"
//        result += "- Ambiguously-spellable PitchSpellingStack: \(ambiguouslySpellable)\n"
//        result += "Edges: "
//        edges.forEach { result += "\n- \($0)" }
//        return result
//    }
//}