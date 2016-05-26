//
//  Graph.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Pitch

internal struct Graph {

    private static func makeLevel(withSpellingsForPitch pitch: Pitch) -> Level {
        let nodes = pitch.spellings.map { Node(spelling: $0) }
        return Level(nodes: nodes)
    }
    
    internal lazy var levels: [Level] = {
        self.pitchSet.map { Graph.makeLevel(withSpellingsForPitch: $0) }
    }()
    
    internal lazy var nodes: [Node] = {
        self.levels.flatMap { $0.nodes }
    }()
    
    private let pitchSet: PitchSet
    
    internal var paths: PathCollection { fatalError() }
    
    internal init(pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
    
    
}
