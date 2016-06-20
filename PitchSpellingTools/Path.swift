//
//  Path.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/18/16.
//
//

import ArrayTools
import Pitch

public enum PitchesRepresentationInPath {
    case neither
    case single(represented: Pitch, unrepresented: Pitch)
    case both
}

public struct Path {
    
    private let nodes: Set<Node>
    
    public init<S: SequenceType where S.Generator.Element == Node>(nodes: S) {
        self.nodes = Set(nodes)
    }
    
    public func hasNode(with pitch: Pitch) -> Bool {
        for node in nodes {
            if node.pitch == pitch { return true }
        }
        return false
    }
    
    public func pitchesRepresented(from dyad: Dyad) -> PitchesRepresentationInPath {
        return .neither
    }
    
    public func satisfies(constraints: [(PitchSpellingDyad) -> Bool]) -> Bool {
        return false
    }
    
    public func applySpellings() -> SpelledPitchSet {
        return SpelledPitchSet(
            nodes.map {
                SpelledPitch(pitch: $0.pitch, spelling: $0.spelling)
            }
        )
    }
}