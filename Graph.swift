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
    
    private static func connect(node: Node, to otherNode: Node) {
        
    }
    
    internal lazy var levels: [Level] = {
        self.pitchSet.map { Graph.makeLevel(withSpellingsForPitch: $0) }
    }()
    
    internal lazy var nodes: [Node] = {
        self.levels.flatMap { $0.nodes }
    }()
    
    internal lazy var edges: [Edge] = {
        var result: [Edge] = []
        for a in 0..<self.levels.count - 1 {
            let levelA = self.levels[a]
            let levelB = self.levels[a + 1]
            for nodeA in levelA.nodes {
                for nodeB in levelB.nodes {
                    let edge = Edge(nodes: (nodeA, nodeB))
                    result.append(edge)
                }
            }
        }
        return result
    }()
    
    internal var paths: PathCollection { fatalError() }

    private let pitchSet: PitchSet
    
    internal init(pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
    
    // connect each node from each level to each node for next level
    /*
     for a in 0..<levels.count - 1 {
        let lowerLevel = levels[a]
        let higherLevel = levels[b]
        for lowerNode in lowerLevel.nodes {
            for higherNode in higherLevel.nodes {
                // connect(node: Node, to otherNode: Node)
            }
        }
     }
    */
}
