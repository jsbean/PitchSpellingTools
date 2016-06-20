//
//  Path.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/18/16.
//
//

import ArrayTools
import Pitch

public struct Path {
    
    public enum PitchesRepresentationInPath {
        case neither
        case single(represented: Pitch, unrepresented: Pitch)
        case both
    }
    
    private let nodes: Set<Node>
    
    public init<S: SequenceType where S.Generator.Element == Node>(_ nodes: S) {
        self.nodes = Set(nodes)
    }
    
    public func node(with pitch: Pitch) -> Node? {
        for node in nodes {
            if node.pitch == pitch { return node }
        }
        return nil
    }
    
    public func hasNode(with pitch: Pitch) -> Bool {
        return node(with: pitch) != nil
    }
    
    public func spelling(for pitch: Pitch) -> PitchSpelling? {
        return node(with: pitch)?.spelling
    }
    
    public func pitchesRepresented(from dyad: Dyad) -> PitchesRepresentationInPath {
        switch (hasNode(with: dyad.higher), hasNode(with: dyad.lower)) {
        case (true, true): return .both
        case (false, true): return .single(represented: dyad.lower, unrepresented: dyad.higher)
        case (true, false): return .single(represented: dyad.higher, unrepresented: dyad.lower)
        case (false, false): return .neither
        }
    }
    
    public func nodesSatisfyAll(
        constraints: [(PitchSpellingDyad) -> Bool],
        for spelling: PitchSpelling
    ) -> Bool
    {
        for dyad in nodes.map({ PitchSpellingDyad(spelling, $0.spelling) }) {
            for constraint in constraints {
                if !constraint(dyad) { return false }
            }
        }
        return true
    }
    
    public func applySpellings() -> SpelledPitchSet {
        return SpelledPitchSet(
            nodes.map {
                SpelledPitch(pitch: $0.pitch, spelling: $0.spelling)
            }
        )
    }
}

extension Path: CustomStringConvertible {
    
    public var description: String {
        return "\(nodes.map { $0 })"
    }
}