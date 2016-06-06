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
    
    // MARK: - Instance Properties
    
    /// All `Dyad` values of the `pitchSet` contained herein, sorted for spelling priority.
    public lazy var dyads: [Dyad]? = {
        self.pitchSet.dyads?.sort {
            $0.interval.spellingPriority < $1.interval.spellingPriority
        }
    }()
    
    /// Wrapper for a dictionary of type `[Pitch: [Node]]`
    private lazy var nodeResource: PitchSpellingNodeResource = {
        PitchSpellingNodeResource(pitches: self.pitchSet)
    }()
    
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
    
    // `PitchSet` to be spelled.
    private var pitchSet: PitchSet
    
    // MARK: - Initializers
    
    /**
     Create a `PitchSetSpeller` with a `PitchSet`.
     */
    public init(_ pitchSet: PitchSet) {
        self.pitchSet = pitchSet
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
        
        // Call upon each of the comparison stages to rank each node, if possible
        attemptRankingOfNodes()
        
        // Jump start ambiguous choosing process by asserting most urgent edge ranked
        rankNodesOfHighestPriorityEdgeIfNecessary()
        
        // Penalize the nodes of the edges that are valid out-of-context,
        // yet are sub-optimal for this context
        penalizeAlmostGoodEnoughEdges()
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
        for case
            let (index, fullyAmbiguous as FullyAmbiguousPitchSpellingRanker)
            in rankers.enumerate()
        {
            fullyAmbiguous.almostGoodEnoughEdges.forEach {
                $0.penalizeNodes(amount: rankWeight(for: index))
            }
        }
    }
    
    private func highestRankedPitches() throws -> SpelledPitchSet {
        
        return SpelledPitchSet(
            try nodeResource.pitches.map { pitch in
                guard let spelling = nodeResource.highestRanked(for: pitch)?.spelling else {
                    throw PitchSpelling.Error.noSpellingForPitch(pitch)
                }
                return SpelledPitch(pitch, spelling)
            }
        )
    }
    
    // TODO: Refine
    private func rankWeight(for position: Int) -> Float {
        guard let dyads = dyads else { return 0 }
        return (Float(dyads.count - position) / Float(dyads.count)) / 2
    }
}
