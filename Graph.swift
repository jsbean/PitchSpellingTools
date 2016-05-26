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
    
    internal lazy var nodes: [Node] = { self.levels.flatMap { $0.nodes } }()
    
    internal lazy var paths: [[Node]] = {
        
        if self.levels.count == 1 { return self.levels.first!.nodes.map { [$0] } }
        var result: [[Node]] = []
        
        // Create connections
        for a in 0..<self.levels.count - 1 {
            let levelA = self.levels[a]
            let levelB = self.levels[a + 1]

            for nodeA in levelA.nodes {
                
                // encapsulate below surface of Path
                var paths = result.filter { $0.contains(nodeA) }
                result = result.filter { !$0.contains(nodeA) }
                
                for nodeB in levelB.nodes {
                    if paths.count == 0 { paths = [[nodeA]] }
                    for path in paths {
                        var newPath = path
                        newPath.append(nodeB)
                        result.append(newPath)
                    }
                }
            }
        }
        return result
    }()

    private let pitchSet: PitchSet
    
    internal init(pitchSet: PitchSet) {
        self.pitchSet = pitchSet
    }
}
