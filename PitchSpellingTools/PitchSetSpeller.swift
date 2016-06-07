//
//  PitchSetSpeller.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/17/16.
//
//

import ArrayTools
import Pitch

/**
 Spells `PitchSet` values.
 */
public final class PitchSetSpeller: PitchSpeller {
    
    // MARK: - Associated Types
    
    /// The type output provided
    public typealias Result = SpelledPitchSet
    
    // MARK: - Instance Properties
    
    /// All `Dyad` values of the `pitchSet` contained herein, sorted for spelling priority.
    public lazy var dyads: [Dyad]? = {
        self.pitchSet.dyads?.sort {
            $0.interval.spellingPriority < $1.interval.spellingPriority
        }
    }()
    
    /// Wrapper for a dictionary of type `[Pitch: [PitchSpellingNode]]`
    public lazy var nodeResource: PitchSpellingNodeResource = {
        return PitchSpellingNodeResource(pitches: self.pitchSet)
    }()
    
    /// All `PitchSpellingNodes` contained herein.
    public var nodes: [PitchSpellingNode] {
        return nodeResource.nodes
    }
    
    /// Factory that creates `PitchSpellingRanking` objects applicable for this `PitchSet`.
    private lazy var rankerFactory: PitchSpellingRankerFactory = {
        PitchSpellingRankerFactory(nodeResource: self.nodeResource)
    }()
    
    /// `PitchSpellingRanking` objects generated for each `PitchSpellingDyad` contained herein.
    private lazy var rankers: [PitchSpellingRanking]? = {
        self.dyads?.map { self.rankerFactory.makeRanker(for: $0) }
    }()
    
    /// If the `PitchSet` herein can be objectively spelled or has only one `Pitch` value.
    private var pitchSetIsObjectivelySpellableOrMonadic: Bool {
        return pitchSet.allMatch { $0.canBeSpelledObjectively } || pitchSet.isMonadic
    }
    
    /// The influence that this `PitchSetSpeller` has when ranking `PitchSpellingNodes`.
    /// - note: For use when used by `PitchSequenceSpeller`.
    /// - note: Consider changing the name of this, as it means something different ...
    private let rank: Float
    
    // `PitchSet` to be spelled.
    private var pitchSet: PitchSet
    
    // MARK: - Initializers
    
    /**
     Create a `PitchSetSpeller` with a `PitchSet`.
     
     - note: With this intialization method, all of the `PitchSpellingNode` objects are
        generated specifically for this `PitchSetSpeller`.
     
        If a wider context is needed (e.g., when spelling sequences of `PitchSet` values), 
        use `init(pitchSet:nodeResource:rank)`.
     */
    public init(_ pitchSet: PitchSet) {
        self.pitchSet = pitchSet
        self.rank = 1
    }
    
    /**
     Create a `PitchSetSpeller with a `PitchSet`.
     
     - parameter pitchSet:     `PitchSet` value to be spelled.
     - parameter nodeResource: `NodeResource` containing all `PitchSpellingNode` objects 
        applicable to this `PitchSetSpeller`
     - parameter rank:         Multiplier
     
     - TODO: Consider changing name of rank 
     (because it means something slightly different than the other `rank` variables).
     */
    public init(
        pitchSet: PitchSet,
        nodeResource: PitchSpellingNodeResource,
        rank: Float = 1
    )
    {
        self.pitchSet = pitchSet
        self.rank = rank
        self.nodeResource = nodeResource
    }
    
    // MARK: - Instance Methods
    
    /**
     - throws: `PitchSpelling.Error` if unable to apply `PitchSpelling` objects to the given
     `PitchSet`.
     
     - returns: `SpelledPitchSet` containing spelled versions of the given `PitchSet`.
     */
    public func spell() throws -> SpelledPitchSet {
        
        // Exit early is pitchSet is empty
        if pitchSet.isEmpty { return SpelledPitchSet([]) }

        return pitchSetIsObjectivelySpellableOrMonadic
            ? try spelledPitchSetWithDefaultSpellings()
            : try spelledPitchSetByCreatingRankers()
    }
    
    /**
     Compare possible spelling options, and apply rankings upon these options.
     */
    public func applyRankings() {
        attemptRankingOfNodes()
        rankNodesOfHighestPriorityEdgeIfNecessary()
        penalizeAlmostGoodEnoughEdges()
    }
    
    /**
     - throws: `PitchSpelling.Error` if any `Pitch` cannot be spelled with current technology.
     
     - returns: `SpelledPitchSet` representation of the `PitchSet` value given at `init`.
     */
    public func highestRankedPitches() throws -> SpelledPitchSet {
        
        return SpelledPitchSet(
            try nodeResource.pitches.map { pitch in
                guard let spelling = nodeResource.highestRanked(for: pitch)?.spelling else {
                    throw PitchSpelling.Error.noSpellingForPitch(pitch)
                }
                return SpelledPitch(pitch, spelling)
            }
        )
    }
    
    private func spelledPitchSetWithDefaultSpellings() throws -> SpelledPitchSet {
        return try pitchSet.spelledWithDefaultSpellings()
    }
    
    private func spelledPitchSetByCreatingRankers() throws -> SpelledPitchSet {
        applyRankings()
        return try highestRankedPitches()
    }
    
    private func attemptRankingOfNodes() {
        rankers?.enumerate().forEach { position, ranker in
            ranker.applyRankings(withAmount: rankWeight(for: position))
        }
    }
    
    private func rankNodesOfHighestPriorityEdgeIfNecessary() {
        if nodeResource.noNodesHaveBeenRanked { rankNodesOfHighestPriorityEdge() }
    }
    
    private func rankNodesOfHighestPriorityEdge() {
        guard let first = rankers?[0] as? FullyAmbiguousPitchSpellingRanker else { return }
        first.highestRanked?.applyRankToNodes(rank: 1)
    }
    
    private func penalizeAlmostGoodEnoughEdges() {
        guard let rankers = rankers else { return }
        for case let (index, fullyAmbiguous as FullyAmbiguousPitchSpellingRanker)
            in rankers.enumerate()
        {
            fullyAmbiguous.almostGoodEnoughEdges.forEach {
                $0.penalizeNodes(amount: rankWeight(for: index))
            }
        }
    }
    
    // Clarify inheriting rank
    // TODO: Refine
    private func rankWeight(for position: Int) -> Float {
        guard let dyads = dyads else { return 0 }
        return rank * (Float(dyads.count - position) / Float(dyads.count)) / 2
    }
}

extension PitchSetSpeller: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        return "PitchSetSpeller: \(nodeResource.description)"
    }
}