//
//  Edge.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import ArithmeticTools

final class Edge {
    
    let a: Node
    let b: Node
    
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
    
    init(_ a: Node, _ b: Node) {
        self.a = a
        self.b = b
    }
    
    func penalizeNodes(withWeight weight: Float) {
        // TODO: encapsulate under node surface
        [a,b].forEach {
            if $0.rank == nil { $0.rank = 1 }
            $0.rank! -= weight
        }
    }
    
    func hasNode(node: Node) -> Bool {
        return [a,b].contains(node)
    }
}

extension Edge: Comparable { }

func == (lhs: Edge, rhs: Edge) -> Bool {
    return lhs.a == rhs.a && lhs.b == rhs.b
}

func < (lhs: Edge, rhs: Edge) -> Bool {
    return lhs.rank < rhs.rank
}

extension Edge: CustomStringConvertible {
    
    var description: String { return "\(a) -> \(b) rank: \(rank)" }
}
