//
//  PitchSequenceSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/31/16.
//
//

import ArrayTools
import Pitch

/// - TODO: Change this to `PitchSubSequenceSpeller`
/// - TODO: Implement PitchSequenceSpeller to aggregate the results of `PitchSubSequenceSpeller`
public final class PitchSequenceSpeller: PitchSpeller {
    
    // Change this to a dedicated `SequenceType` at some point.
    public typealias Result = [SpelledPitchSet]
    
    public var nodes: [PitchSpellingNode] {
        return nodeResource.nodes
    }
    
    public lazy var nodeResource: PitchSpellingNodeResource = {
        PitchSpellingNodeResource(pitches: PitchSet(self.sets))
    }()
    
    let sets: [PitchSet]
    
    /**
     - TODO: Make richer SequenceType support
     - warning: Incomplete documentation
     */
    public init(sets: [PitchSet]) {
        self.sets = sets
    }
    
    /** 
     - TODO: Return `SpelledPitchSetSequence`
     
     */
    public func spell() throws -> [SpelledPitchSet] {
        
        
        fatalError()
    }
    
    /**
     - TODO: Apply teleological ranking (second pair has more influence than first)
     */
    public func applyRankings() {
        
        // Create universal node resource
        
         
        // TODO: refactor into private method
        let individualSpellers = sets.map { PitchSetSpeller($0, nodeResource: nodeResource[$0]!) }
        
        // TODO: refactor into private method
        let joinedSpellers = sets.adjacentPairs!.map { (first, second) in
            PitchSetSpeller(first.formUnion(with: second))
        }
        
        // Do local work
        individualSpellers.forEach { $0.applyRankings() }
        
        // Work out
        joinedSpellers.forEach { $0.applyRankings() }
        
        // Work further out
        // TODO
        
        // commit back on a local scale
        individualSpellers.forEach {
            let spelledPitchSet = try! $0.highestRankedPitches()
            print("spelledPitchSet: \(spelledPitchSet)")
        }
        
        // TODO: apply teleological ranking (increase weight towards end of subsequence)
        
        print("resource after initial ranking: \(nodeResource)")
    }
    
    // TEMP
    private func rankWeight(for position: Int) -> Float {
        return (Float(sets.count - position) / Float(sets.count)) / 2
    }
}
