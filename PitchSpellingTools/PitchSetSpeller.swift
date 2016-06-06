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
    
    private lazy var dyads: [Dyad] = {
        self.pitchSet.dyads.sort {
            $0.interval.spellingUrgency < $1.interval.spellingUrgency
        }
    }()
    
    private lazy var nodeResource: NodeResource = {
        NodeResource(pitches: self.pitchSet) }(
    )
    
    private var allNodesHaveBeenRanked: Bool {
        return nodeResource.allNodesHaveBeenRanked
    }
    
    /// Factory that creates `ComparisonStage` objects applicable for this `PitchSet`
    private lazy var comparisonStageFactory: ComparisonStageFactory = {
        ComparisonStageFactory(nodeResource: self.nodeResource)
    }()
    
    // `ComparisonStage` objects built that can be referenced after initial decision making
    private lazy var comparisonStages: [ComparisonStage] = {
        self.dyads.map { self.comparisonStageFactory.makeComparisonStage(for: $0) }
    }()
    
    private var pitchSetIsObjectivelySpellableOrMonadic: Bool {
        return pitchSet.allMatch { $0.canBeSpelledObjectively } || pitchSet.isMonadic
    }
    
    // `PitchSet` to be spelled
    private let pitchSet: PitchSet
    
    /**
     Create a `PitchSetSpeller` with a `PitchSet`.
     */
    public init(_ pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
    
    // TODO: incorporate external coarse / fine preferences
    
    /**
     - throws: `PitchSpelling.Error` if unable to apply `PitchSpelling` objects to the given
     `PitchSet`.
     
     - returns: `SpelledPitchSet` containing spelled versions of the given `PitchSet`.
     */
    public func spell() throws -> SpelledPitchSet {
        
        // Exit early is pitchSet is empty
        if pitchSet.isEmpty { return SpelledPitchSet(pitches: []) }

        return pitchSetIsObjectivelySpellableOrMonadic
            ? try spelledPitchSetWithDefaultSpellings()
            : try spelledPitchSetByCreatingComparisonStages()
    }
    
    private func spelledPitchSetWithDefaultSpellings() throws -> SpelledPitchSet {
        return try pitchSet.spelledWithDefaultSpellings()
    }
    
    // TODO: Make throw
    private func spelledPitchSetByCreatingComparisonStages() throws -> SpelledPitchSet {

        // Call upon each of the comparison stages to rank each node if possible
        attemptRankingOfNodes()
        
        // Jump start ambiguous choosing process by asserting most urgent edge ranked
        rankNodesOfHighestPriorityEdgeIfNecessary()
        
        // TODO: refactor into own private method
        for c in comparisonStages.indices {
            
            // TODO: come up with better names
            guard let ambiguous = comparisonStages[c] as? FullyAmbiguousComparisonStage
            else { continue }

            // TODO: make this not a reach-around
            let bestRanked = ambiguous.edges.extremeElements(>) { $0.rank }
            let notGoodEnough = bestRanked.extremeElements(<) { $0.meanRank ?? Float.min }
            for edge in notGoodEnough { edge.penalizeNodes(withWeight: rankWeight(for: c)) }
        }
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
        let first = comparisonStages[0] as! FullyAmbiguousComparisonStage
        first.highestRanked!.a.rank = 1
        first.highestRanked!.b.rank = 1
    }
    
    private func highestRankedPitches() throws -> SpelledPitchSet {
        nodeResource.sortByRank()
        return SpelledPitchSet(pitches:
            nodeResource.reduce([]) { array, nodesByPitch in
                guard let spelling = nodesByPitch.1.first?.spelling else { return array }
                return array + SpelledPitch(pitch: nodesByPitch.0, spelling: spelling)
            }
        )
    }
    
    // TODO: refine
    private func rankWeight(for position: Int) -> Float {
        return (Float(dyads.count - position) / Float(dyads.count)) / 2
    }
}
