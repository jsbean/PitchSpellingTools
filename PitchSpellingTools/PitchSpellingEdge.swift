//
//  PitchSpellingEdge.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import ArithmeticTools

public final class PitchSpellingEdge {
    
    let a: PitchSpellingNode
    let b: PitchSpellingNode
    
    public var meanRankOfNodes: Float? {
        switch (a.rank, b.rank) {
        case let (aRank?, bRank?): return [aRank, bRank].mean
        default: return nil
        }
    }
    
    lazy var pitchSpellingDyad: PitchSpellingDyad = {
        PitchSpellingDyad(self.a.spelling, self.b.spelling)
    }()
    
    public var rank: Float = 1
    
    public init(_ a: PitchSpellingNode, _ b: PitchSpellingNode) {
        self.a = a
        self.b = b
    }
    
    public func applyRankToNodes(rank rank: Float) {
        [a,b].forEach { $0.apply(rank) }
    }
    
    public func penalizeNodes(withWeight weight: Float) {
        [a,b].forEach { $0.penalize(by: weight) }
    }
    
    func hasNode(node: PitchSpellingNode) -> Bool {
        return [a,b].contains(node)
    }
}

extension PitchSpellingEdge: Comparable { }

public func == (lhs: PitchSpellingEdge, rhs: PitchSpellingEdge) -> Bool {
    return lhs.a == rhs.a && lhs.b == rhs.b
}

public func < (lhs: PitchSpellingEdge, rhs: PitchSpellingEdge) -> Bool {
    return lhs.rank < rhs.rank
}

extension PitchSpellingEdge: CustomStringConvertible {
    
    public var description: String { return "\(a) -> \(b) rank: \(rank)" }
}
