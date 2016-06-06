//
//  PitchSpellingEdge.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import ArithmeticTools

final class PitchSpellingEdge {
    
    let a: PitchSpellingNode
    let b: PitchSpellingNode
    
    var meanRank: Float? {
        switch (a.rank, b.rank) {
        case let (aRank?, bRank?): return [aRank, bRank].mean
        default: return nil
        }
    }
    
    lazy var pitchSpellingDyad: PitchSpellingDyad = {
        PitchSpellingDyad(self.a.spelling, self.b.spelling)
    }()
    
    var rank: Float = 1
    
    init(_ a: PitchSpellingNode, _ b: PitchSpellingNode) {
        self.a = a
        self.b = b
    }
    
    func applyRankToNodes(rank rank: Float) {
        [a,b].forEach { $0.rank = rank }
    }
    
    func penalizeNodes(withWeight weight: Float) {
        // TODO: encapsulate under node surface
        [a,b].forEach {
            if $0.rank == nil { $0.rank = 1 }
            $0.rank! -= weight
        }
    }
    
    func hasNode(node: PitchSpellingNode) -> Bool {
        return [a,b].contains(node)
    }
}

extension PitchSpellingEdge: Comparable { }

func == (lhs: PitchSpellingEdge, rhs: PitchSpellingEdge) -> Bool {
    return lhs.a == rhs.a && lhs.b == rhs.b
}

func < (lhs: PitchSpellingEdge, rhs: PitchSpellingEdge) -> Bool {
    return lhs.rank < rhs.rank
}

extension PitchSpellingEdge: CustomStringConvertible {
    
    var description: String { return "\(a) -> \(b) rank: \(rank)" }
}
