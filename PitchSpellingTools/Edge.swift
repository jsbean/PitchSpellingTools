//
//  Edge.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Foundation

final class Edge: Rankable {
    
    var rank: Float?
    let pitchSpellingDyad: PitchSpellingDyad
    
    let a: Node
    let b: Node
    
    init(_ a: Node, _ b: Node) {
        self.a = a
        self.b = b
        self.pitchSpellingDyad = PitchSpellingDyad(a.spelling, b.spelling)
    }
}

extension Edge: CustomStringConvertible {
    
    var description: String {
        return "\(pitchSpellingDyad); rank: \(rank)"
    }
}