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
    public lazy var dyads: [Dyad] = {
        self.pitchSet.dyads.sort {
            $0.interval.spellingPriority < $1.interval.spellingPriority
        }
    }()
    
    /// Wrapper for a dictionary of type `[Pitch: [Node]]`
    private lazy var nodeResource: NodeResource = {
        NodeResource(pitches: self.pitchSet) }(
    )
    
    /// Factory that creates `ComparisonStage` objects applicable for this `PitchSet`.
    private lazy var comparisonStageFactory: ComparisonStageFactory = {
        ComparisonStageFactory(nodeResource: self.nodeResource)
    }()
    
    /// `ComparisonStage` objects generated for each `PitchSpellingDyad` contained herein.
    private lazy var comparisonStages: [ComparisonStage] = {
        self.dyads.map { self.comparisonStageFactory.makeComparisonStage(for: $0) }
    }()
    
    /// If the `PitchSet` herein can be objectively spelled or has only one `Pitch` value.
    private var pitchSetIsObjectivelySpellableOrMonadic: Bool {
        return pitchSet.allMatch { $0.canBeSpelledObjectively } || pitchSet.isMonadic
    }
    
    // `PitchSet` to be spelled
    private let pitchSet: PitchSet
    
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
            : try spelledPitchSetByCreatingComparisonStages()
    }
    
    private func spelledPitchSetWithDefaultSpellings() throws -> SpelledPitchSet {
        return try pitchSet.spelledWithDefaultSpellings()
    }
    
    private func spelledPitchSetByCreatingComparisonStages() throws -> SpelledPitchSet {

        // Call upon each of the comparison stages to rank each node, if possible
        attemptRankingOfNodes()
        
        // Jump start ambiguous choosing process by asserting most urgent edge ranked
        rankNodesOfHighestPriorityEdgeIfNecessary()

        // Penalize the nodes of the edges that are valid out-of-context, 
        // yet are sub-optimal for this context
        penalizeAlmostGoodEnoughEdges()
        
        return try highestRankedPitches()
    }
    
    private func attemptRankingOfNodes() {
        comparisonStages
            .enumerate()
            .forEach {
                position, comparisonStage in
                comparisonStage.applyRankings(withWeight: rankWeight(for: position))
            }
    }
    
    private func rankNodesOfHighestPriorityEdgeIfNecessary() {
        if nodeResource.noNodesHaveBeenRanked { rankNodesOfHighestPriorityEdge() }
    }
    
    private func rankNodesOfHighestPriorityEdge() {
        guard let first = comparisonStages[0] as? FullyAmbiguousComparisonStage else { return }
        first.highestRanked?.applyRankToNodes(rank: 1)
    }
    
    private func penalizeAlmostGoodEnoughEdges() {
        for case
            let (index, fullyAmbiguous as FullyAmbiguousComparisonStage)
            in comparisonStages.enumerate()
        {
            fullyAmbiguous.almostGoodEnoughEdges.forEach {
                $0.penalizeNodes(withWeight: rankWeight(for: index))
            }
        }
    }
    
    private func highestRankedPitches() throws -> SpelledPitchSet {
        nodeResource.sortByRank()
        return SpelledPitchSet(
            nodeResource.reduce([]) { array, nodesByPitch in
                guard let spelling = nodesByPitch.1.first?.spelling else { return array }
                return array + SpelledPitch(pitch: nodesByPitch.0, spelling: spelling)
            }
        )
    }
    
    // TODO: Refine
    private func rankWeight(for position: Int) -> Float {
        return (Float(dyads.count - position) / Float(dyads.count)) / 2
    }
}
