//
//  PitchSubSequenceSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import ArrayTools
import Pitch

/// - TODO: Change this to `PitchSubSequenceSpeller`
/// - TODO: Implement PitchSubSequenceSpeller to aggregate the results of `PitchSubSequenceSpeller`
/// - TODO: Implement segmentation
public final class PitchSubSequenceSpeller: PitchSpeller {
    
    // Change this to a dedicated `SequenceType` at some point.
    public typealias Result = [SpelledPitchSet]
    
    public var nodes: [PitchSpellingNode] {
        return nodeResource.nodes
    }
    
    public lazy var nodeResource: PitchSpellingNodeResource = {
        PitchSpellingNodeResource(pitches: PitchSet(self.sequence))
    }()
    
    private lazy var individualSpellers: [PitchSetSpeller] = {
        self.sequence.map { PitchSetSpeller(pitchSet: $0, nodeResource: self.nodeResource[$0]!) }
    }()
    
    private lazy var joinedSpellers: [PitchSetSpeller] = {
        guard let adjacentPairs = self.sequence.adjacentPairs else { return [] }
        return adjacentPairs.enumerate().map {
            index, pair in
            let newSet = pair.0.formUnion(with: pair.1)
            return PitchSetSpeller(
                pitchSet: newSet,
                nodeResource: self.nodeResource[newSet]!,
                rank: self.rankWeight(for: index)
            )
        }
    }()
    
    private let sequence: PitchSetSequence
    
    /**
     - TODO: Make richer SequenceType support
     - warning: Incomplete documentation
     */
    public init(_ sequence: PitchSetSequence) {
        self.sequence = sequence
    }
    
    /** 
     - TODO: Return `SpelledPitchSetSequence`
     - warning: Not yet implemented!
     */
    public func spell() throws -> Result {
        applyRankings()
        return try highestRankedPitches()
    }

    public func applyRankings() {
        joinedSpellers.forEach { $0.applyRankings() }
    }
    
    private func highestRankedPitches() throws -> Result {
        return try individualSpellers.map { return try $0.highestRankedPitches() }
    }
    
    // Here, rank is weighted towards the end of a sequence
    private func rankWeight(for position: Int) -> Float {
        return (Float(position + 1) / Float(sets.count)) / 2
    }
}
