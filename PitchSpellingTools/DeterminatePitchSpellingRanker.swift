//
//  DeterminatePitchSpellingRanker.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/2/16.
//
//

import Foundation

/// PitchSpellingRanker for two objectively spellable `PitchSpellingNode` objects.
public final class DeterminatePitchSpellingRanker: PitchSpellingRanking {
    
    let a: PitchSpellingNode
    let b: PitchSpellingNode
    
    /// - warning: There are no edges here.
    public var edges: [PitchSpellingEdge] { fatalError("There are no edges here") }
    
    // MARK: - Initializers
    
    /**
     Create a `DeterminatePitchSpellingRanker` with two objectively spellable 
     `PitchSpellingNode` objects.
     */
    public init(_ a: PitchSpellingNode, _ b: PitchSpellingNode) {
        self.a = a
        self.b = b
        self.applyRankings(withAmount: 1)
    }
    
    /**
     - warning: Sets the ranking to both nodes to `1`.
     */
    public func applyRankings(withAmount amount: Float) {
        a.rank = 1
        b.rank = 1
    }
}

extension DeterminatePitchSpellingRanker: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String { return "DeterminatePitchSpellingRanker: \(a); \(b)" }
}