//
//  DeterminateComparisonStage.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/2/16.
//
//

import Foundation

// Gives objectively spellable dyad perfect ranking
final class DeterminateComparisonStage: ComparisonStage {
    
    let a: Node
    let b: Node
    
    var edges: [Edge] { return [] }
    
    init(_ a: Node, _ b: Node) {
        self.a = a
        self.b = b
        self.applyRankings(withWeight: 1)
    }
    
    func applyRankings(withWeight weight: Float) {
        a.rank = 1
        b.rank = 1
    }
}

extension DeterminateComparisonStage: CustomStringConvertible {
    
    var description: String { return "DeterminateComparisonStage: \(a); \(b)" }
}