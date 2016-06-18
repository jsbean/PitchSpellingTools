//
//  Path.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/18/16.
//
//

import ArrayTools

public struct Path {
    
    private let nodes: Set<Node>
    
    public init<S: SequenceType where S.Generator.Element == Node>(nodes: S) {
        self.nodes = Set(nodes)
    }
    
    public func applySpellings() -> SpelledPitchSet {
        return SpelledPitchSet(
            nodes.map {
                SpelledPitch(pitch: $0.pitch, spelling: $0.spelling)
            }
        )
    }
}