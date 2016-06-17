////
////  PitchSpellingNode.swift
////  PitchSpellingTools
////
////  Created by James Bean on 5/24/16.
////
////
//
//import Pitch
//
///**
// PitchSpellingNode in a `Graph`, holding a `PitchSpelling` object for a `Pitch` within a `PitchSet`.
// 
// - note: Consider factoring this out, unless it has a bigger payload than just a `PitchSpelling`
// */
//public final class PitchSpellingNode {
//    
//    public var rank: Float? = nil
//
//    public let pitch: Pitch
//    
//    /// The `PitchSpelling` held by this `PitchSpellingNode`.
//    public let spelling: PitchSpelling
//    
//    /**
//     Create a `PitchSpellingNode` with the given `spelling`.
//     */
//    public init(pitch: Pitch, spelling: PitchSpelling) {
//        self.pitch = pitch
//        self.spelling = spelling
//    }
//    
//    /**
//     Create a `PitchSpellingNode` with a `Pitch` that can be spelled objectively.
//     
//     - returns: `nil` if the given `pitch` is not spellable objectively.
//     */
//    internal init!(objectivelySpellablePitch pitch: Pitch) {
//        guard pitch.canBeSpelledObjectively else { return nil }
//        self.pitch = pitch
//        self.spelling = pitch.defaultSpelling!
//    }
//    
//    public func apply(rank: Float) {
//        self.rank = rank
//    }
//    
//    public func penalize(by amount: Float) {
//        if rank == nil { rank = 1 }
//        rank! -= amount
//    }
//}
//
//extension PitchSpellingNode: Comparable { }
//
//public func == (lhs: PitchSpellingNode, rhs: PitchSpellingNode) -> Bool {
//    return lhs.spelling == rhs.spelling
//}
//
//public func < (lhs: PitchSpellingNode, rhs: PitchSpellingNode) -> Bool {
//    return lhs.rank < rhs.rank
//}
//
//extension PitchSpellingNode: CustomStringConvertible {
//    
//    public var description: String {
//        return "\(spelling); rank: \(rank)"
//    }
//}