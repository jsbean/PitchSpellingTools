//
//  Edge.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Foundation

struct Edge {
    
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
