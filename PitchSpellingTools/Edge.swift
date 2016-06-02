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
    
    lazy var pitchSpellingDyad: PitchSpellingDyad = {
        PitchSpellingDyad(self.a.spelling, self.b.spelling)
    }()
    
    // derives edge rank from ranks of nodes, if possible
    lazy var rank: Float = {
        switch (self.a.rank, self.b.rank) {
        case (nil, nil): return 1
        case let (rank?, nil): return rank
        case let (nil, rank?): return rank
        case let (rankA?, rankB?): return [rankA, rankB].mean!
        }
    }()
    
    init(_ a: Node, _ b: Node) {
        self.a = a
        self.b = b
    }
    
    func isCompatible(withDirection direction: PitchSpelling.CoarseAdjustment.Direction)
        -> Bool
    {
        
        return false
    }
    
    
}

extension Edge: CustomStringConvertible {
    
    var description: String {
        return "\(a) -> \(b) rank: \(rank)"
    }
}
