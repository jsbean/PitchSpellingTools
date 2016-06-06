//
//  DeterminatePitchSpellingRanker.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/2/16.
//
//

import Foundation

// Gives objectively spellable dyad perfect ranking
public final class DeterminatePitchSpellingRanker: PitchSpellingRanking {
    
    let a: PitchSpellingNode
    let b: PitchSpellingNode
    
    public var edges: [PitchSpellingEdge] { fatalError("There are no edges here") }
    
    public init(_ a: PitchSpellingNode, _ b: PitchSpellingNode) {
        self.a = a
        self.b = b
        self.applyRankings(withAmount: 1)
    }
    
    public func applyRankings(withAmount amount: Float) {
        a.rank = 1
        b.rank = 1
    }
}

extension DeterminatePitchSpellingRanker: CustomStringConvertible {
    
    public var description: String { return "DeterminatePitchSpellingRanker: \(a); \(b)" }
}