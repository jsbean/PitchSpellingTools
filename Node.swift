//
//  Node.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Foundation

internal final class Node {
    
    internal let spelling: PitchSpelling
    
    internal var connectedNodes: [Node] = []
    
    internal init(spelling: PitchSpelling) {
        self.spelling = spelling
    }
    
    internal func connect(to node: Node) {
        connectedNodes.append(node)
    }
}

extension Node: CustomStringConvertible {
    
    internal var description: String { return "\(spelling)" }
}
