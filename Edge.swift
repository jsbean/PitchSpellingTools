//
//  Edge.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Foundation

internal final class Edge {
    
    private let before: Node
    private let after: Node
    
    internal init(nodeBefore before: Node, nodeAfter after: Node) {
        self.before = before
        self.after = after
    }
}
