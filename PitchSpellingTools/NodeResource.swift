//
//  NodeResource.swift
//  PitchSpellingTools
//
//  Created by James Bean on 6/2/16.
//
//

import Pitch

internal struct NodeResource {
    
    private var resource: [Pitch: [Node]]
    
    var allNodesHaveBeenRanked: Bool {
        for (_, nodes) in resource {
            for node in nodes {
                if node.rank == nil { return false }
            }
        }
        return true
    }
    
    init(pitchSet: PitchSet) {
        self.resource = pitchSet.reduce([:]) { (dict, pitch) in
            var dict = dict
            dict[pitch] = pitch.spellingsWithoutUnconventionalEnharmonics.map { spelling in
                Node(pitch: pitch, spelling: spelling)
            }
            return dict
        }
    }
    
    subscript (pitch: Pitch) -> [Node]? {
        return resource[pitch]
    }
}
