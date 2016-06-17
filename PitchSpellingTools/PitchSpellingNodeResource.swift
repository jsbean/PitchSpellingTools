////
////  PitchSpellingNodeResource.swift
////  PitchSpellingTools
////
////  Created by James Bean on 6/2/16.
////
////
//
//import Pitch
//
///**
// Wrapper for a dictionary of type `[Pitch: [PitchSpellingNode]]`.
//*/
//public struct PitchSpellingNodeResource {
//    
//    // MARK: - Instance Properties
//    
//    private var resource: [Pitch: [PitchSpellingNode]]
//    
//    /// - warning: No documentation
//    public var pitches: [Pitch] { return resource.reduce([]) { $0 + [$1.0] } }
//    
//    /// All `PitchSpellingNode` values contained herein.
//    public var nodes: [PitchSpellingNode] {
//        return resource.reduce([]) { $0 + $1.1.map { $0 } }
//    }
//    
//    /**
//     `true` if all nodes contained herein have been ranked. Otherwise, `false`.
//    
//     - complexity: O(n)
//    */
//    public var allNodesHaveBeenRanked: Bool {
//        for (_, nodes) in resource {
//            for node in nodes {
//                if node.rank == nil { return false }
//            }
//        }
//        return true
//    }
//    
//    /**
//     `true` if no nodes contained herein have been ranked. Otherwise, `false`.
//     
//     - complexity: O(n)
//    */
//    public var noNodesHaveBeenRanked: Bool {
//        for (_, nodes) in resource {
//            for node in nodes {
//                if node.rank != nil { return false }
//            }
//        }
//        return true
//    }
//    
//    // MARK: - Initializers
//    
//    /**
//     Create a `PitchSpellingNodeResource` with a `SequenceType` containing `Pitch` type values.
//     
//     - warning: The `PitchSpellingNode` objects generated herein assume that unconventional
//     enharmonic spellings are disregarded (e.g., `c flat`, `b sharp`, `d double sharp`, etc.)
//     
//     - TODO: Consider moving this constraint to a publically-available variable.
//     */
//    public init<S: SequenceType where S.Generator.Element == Pitch>(pitches: S) {
//        self.resource = pitches.reduce([:]) { (dict, pitch) in
//            var dict = dict
//            dict[pitch] = pitch.spellingsWithoutUnconventionalEnharmonics.map { spelling in
//                PitchSpellingNode(pitch: pitch, spelling: spelling)
//            }
//            return dict
//        }
//    }
//    
//    /**
//     - warning: Not yet implemented!
//     */
//    public init(sequence: [PitchSet]) {
//        fatalError()
//    }
//    
//    /**
//     - returns: Array of `PitchSpellingNode` values for the given `pitch`, if present.
//     Otherwise, `nil`.
//     */
//    public subscript (pitch: Pitch) -> [PitchSpellingNode]? {
//        get { return resource[pitch] }
//        set { resource[pitch] = newValue }
//    }
//    
//    /**
//     - returns: `PitchSpellingNodeResource` containing only containing the records for the
//     `Pitch` values in the given `pitchSet`, if these `Pitch` values are keys herein.
//     Otherwise, `nil`.
//     */
//    public subscript (pitchSet: PitchSet) -> PitchSpellingNodeResource? {
//        var result: PitchSpellingNodeResource = [:]
//        for pitch in pitchSet {
//            guard let nodes = self[pitch] else { return nil }
//            result[pitch] = nodes
//        }
//        return result
//    }
//    
//    /**
//     - returns: The highest ranked `PitchSpellingNode` for the given `pitch`, if present.
//     Otherwise, `nil`.
//     */
//    public func highestRanked(for pitch: Pitch) -> PitchSpellingNode? {
//        return self[pitch]?.sort { $0.rank > $1.rank }.first
//    }
//}
//
//extension PitchSpellingNodeResource: SequenceType {
//    
//    public func generate() -> AnyGenerator<(Pitch, [PitchSpellingNode])> {
//        var generator = resource.generate()
//        return AnyGenerator { return generator.next() }
//    }
//}
//
//extension PitchSpellingNodeResource: DictionaryLiteralConvertible {
//    
//    public typealias Key = Pitch
//    public typealias Value = [PitchSpellingNode]
//    
//    public init(dictionaryLiteral elements: (Key, Value)...) {
//        self.resource = [:]
//        for (key, value) in elements {
//            resource[key] = value
//        }
//    }
//}
//
//extension PitchSpellingNodeResource: CustomStringConvertible {
//    
//    // MARK: - CustomStringConvertible
//    
//    /// Printed description.
//    public var description: String {
//        return resource.description
//    }
//}