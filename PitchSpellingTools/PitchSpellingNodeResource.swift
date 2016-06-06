//
//  PitchSpellingNodeResource.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/2/16.
//
//

import Pitch

/**
 Wrapper for a dictionary of type `[Pitch: [PitchSpellingNode]]`.
*/
public struct PitchSpellingNodeResource {
    
    // MARK: - Instance Properties
    
    private var resource: [Pitch: [PitchSpellingNode]]
    
    public var pitches: [Pitch] { return resource.reduce([]) { $0 + [$1.0] } }
    
    /// All `PitchSpellingNode` values contained herein.
    public var nodes: [PitchSpellingNode] { return resource.reduce([]) { $0 + $1.1.map { $0 } } }
    
    /**
     `true` if all nodes contained herein have been ranked. Otherwise, `false`.
    
     - complexity: O(n)
    */
    public var allNodesHaveBeenRanked: Bool {
        for (_, nodes) in resource {
            for node in nodes {
                if node.rank == nil { return false }
            }
        }
        return true
    }
    
    /**
     `true` if no nodes contained herein have been ranked. Otherwise, `false`.
     
     - complexity: O(n)
    */
    public var noNodesHaveBeenRanked: Bool {
        for (_, nodes) in resource {
            for node in nodes {
                if node.rank != nil { return false }
            }
        }
        return true
    }
    
    // MARK: - Initializers
    
    /**
     Create a `PitchSpellingNodeResource` with a `SequenceType` containing `Pitch` type values.
     
     - warning: The `PitchSpellingNode` objects generated herein assume that unconventional
     enharmonic spellings are disregarded (e.g., `c flat`, `b sharp`, `d double sharp`, etc.)
     
     - TODO: Consider moving this constraint to a publically-available variable.
     */
    public init<S: SequenceType where S.Generator.Element == Pitch>(pitches: S) {
        self.resource = pitches.reduce([:]) { (dict, pitch) in
            var dict = dict
            dict[pitch] = pitch.spellingsWithoutUnconventionalEnharmonics.map { spelling in
                PitchSpellingNode(pitch: pitch, spelling: spelling)
            }
            return dict
        }
    }
    
    /**
     - returns: Array of `PitchSpellingNode` values for the given `pitch`, if present.
     Otherwise, `nil`.
     */
    public subscript (pitch: Pitch) -> [PitchSpellingNode]? {
        return resource[pitch]
    }
    
    /**
     - returns: The highest ranked `PitchSpellingNode` for the given `pitch`, if present.
     Otherwise, `nil`.
     */
    public func highestRanked(for pitch: Pitch) -> PitchSpellingNode? {
        return self[pitch]?.sort { $0.rank > $1.rank }.first
    }
    
    /**
     Sorts the nodes for each pitch by their rank in descending order.
     */
    public mutating func sortByRank() {
        for (pitch, nodes) in resource { resource[pitch] = nodes.sort { $0.rank > $1.rank } }
    }
}

extension PitchSpellingNodeResource: SequenceType {
    
    public func generate() -> AnyGenerator<(Pitch, [PitchSpellingNode])> {
        var generator = resource.generate()
        return AnyGenerator { return generator.next() }
    }
}