//
//  Edge.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Foundation

internal struct Edge {
    
    internal let nodes: (Node, Node)
    
    internal init(nodes: (Node, Node)) {
        self.nodes = nodes
    }
}
