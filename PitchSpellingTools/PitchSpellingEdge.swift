////
////  PitchSpellingEdge.swift
////  PitchSpellingTools
////
////  Created by James Bean on 5/24/16.
////
////
//
//import ArithmeticTools
//
///// Edge between two `PitchSpellingNode` objects.
//public final class PitchSpellingEdge {
//    
//    // MARK: - Instance Properties
//    
//    let a: PitchSpellingNode
//    let b: PitchSpellingNode
//    
//    
//    /**
//     Mean of current `rank` values of `PitchSpellingNode` objects contained herein, if both
//     nodes have been ranked. Otherwise, `false`.
//     */
//    public var meanRankOfNodes: Float? {
//        switch (a.rank, b.rank) {
//        case let (aRank?, bRank?): return [aRank, bRank].mean
//        default: return nil
//        }
//    }
//    
//    /**
//     `PitchSpellingDyad` value containing the spellings of each `PitchSpellingNode` object
//     contained herein.
//    */
//    public lazy var pitchSpellingDyad: PitchSpellingDyad = {
//        PitchSpellingDyad(self.a.spelling, self.b.spelling)
//    }()
//    
//    /// Rank of this `PitchSpellingEdge`.
//    public var rank: Float = 1
//    
//    // MARK: - Initializers
//    
//    /**
//     Create a `PitchSpellingEdge` with two `PitchSpellingNode` objects.
//     */
//    public init(_ a: PitchSpellingNode, _ b: PitchSpellingNode) {
//        self.a = a
//        self.b = b
//    }
//    
//    // MARK: - Instance Methods
//    
//    /**
//     Applies the given `rank` to each `PitchSpellingNode` object contained herein.
//     */
//    public func applyRankToNodes(rank rank: Float) {
//        [a,b].forEach { $0.apply(rank) }
//    }
//    
//    /**
//     Reduces the `rank` value by the given `amount` for each `PitchSpellingNode` object 
//     contained herein.
//     */
//    public func penalizeNodes(amount amount: Float) {
//        [a,b].forEach { $0.penalize(by: amount) }
//    }
//}
//
//extension PitchSpellingEdge: Comparable { }
//
//public func == (lhs: PitchSpellingEdge, rhs: PitchSpellingEdge) -> Bool {
//    return lhs.a == rhs.a && lhs.b == rhs.b
//}
//
//public func < (lhs: PitchSpellingEdge, rhs: PitchSpellingEdge) -> Bool {
//    return lhs.rank < rhs.rank
//}
//
//extension PitchSpellingEdge: CustomStringConvertible {
//    
//    // MARK: - CustomStringConvertible
//    
//    /// Printed description.
//    public var description: String { return "\(a) -> \(b) rank: \(rank)" }
//}
