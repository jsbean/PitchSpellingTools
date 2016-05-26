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
    
    private var nodes: [Node] = []
    
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
    
    internal var description: String { return "\(nodes)" }
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