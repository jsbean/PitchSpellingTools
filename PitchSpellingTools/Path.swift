
//
//  Path.swift
//  PitchSpellingTools
//
//  Created by James Bean on 5/24/16.
//
//

import Foundation

/**
 A possible spelled representation of all `Pitch` objects in a `PitchSet`.
 */
internal struct Path {
    
    /// - warning: Not yet implemented!
    /// variance in distance from middle c
    internal var variance: Float { fatalError() }
    
    internal var isStepPreserving: Bool {
        for edge in edges { if !edge.isStepPreserving { return false } }
        return true
    }
    
    private var edges: [PitchSpellingDyad] {
        var result: [PitchSpellingDyad] = []
        for n in 0 ..< nodes.count - 1 {
            let nodeA = nodes[n]
            let nodeB = nodes[n + 1]
            let edge = PitchSpellingDyad(nodeA.spelling, nodeB.spelling)
            result.append(edge)
        }
        return result
    }
    
    private var nodes: [Node] = []
    
    /**
     Create a `Path` with the given array of `Node` objects.
     */
    internal init(nodes: [Node]) {
        self.nodes = nodes
    }
    
    /**
     - returns: `true` is the given `node` is contained herein. Otherwise, `false`.
     */
    internal func contains(node: Node) -> Bool {
        return nodes.contains(node)
    }
    
    /**
     Add the given `node`.
     */
    internal mutating func append(node: Node) {
        nodes.append(node)
    }
}

extension Path: CustomStringConvertible {
    
    internal var description: String {
        return nodes.map { "\($0.spelling)" }.joinWithSeparator(" -> ")
    }
}

/**
 - returns: `Path` object with the given `Node` appended to the given `Path`.
 */
internal func + (lhs: Path, rhs: Node) -> Path {
    var path = lhs
    path.append(rhs)
    return path
}

/**
 - returns: `Path` object with the given `Node` appended to the given `Path`.
 */
internal func + (lhs: Node, rhs: Path) -> Path {
    var path = rhs
    path.append(lhs)
    return path
}