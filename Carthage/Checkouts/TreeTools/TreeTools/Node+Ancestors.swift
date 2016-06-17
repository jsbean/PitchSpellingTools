////
////  Node+Ancestors.swift
////  TreeTools
////
////  Created by James Bean on 3/11/16.
////  Copyright © 2016 James Bean. All rights reserved.
////
//
//import Foundation
//import ArrayTools
//
//extension Node {
//    
//    // MARK: - Ancestors
//    
//    /// If Node is a Container (has children Nodes)
//    public var isContainer: Bool { return children.count > 0 }
//    
//    /// If Node is the Root of a Tree (has no parent Node)
//    public var isRoot: Bool { return parent == nil }
//    
//    /// The Root Node of Tree containing Node
//    public var root: Node {
//        
//        func ascendToGetRoot(of node: Node) -> Node {
//            guard let parent = node.parent else { return node }
//            return ascendToGetRoot(of: parent)
//        }
//        
//        return ascendToGetRoot(of: self)
//    }
//    
//    /// Array of all Node objects between (and including) `self` up to `root`.
//    public var pathToRoot: [Node] {
//        
//        func ascendToGetPathToRoot(of node: Node, result: [Node]) -> [Node] {
//            guard let parent = node.parent else { return result + node }
//            return ascendToGetPathToRoot(of: parent, result: result + node)
//        }
//        
//        return ascendToGetPathToRoot(of: self, result: [])
//    }
//    
//    /**
//     - returns: `true` if `Node` has given `node` as ancestor. Otherwise `false`.
//     */
//    public func hasAncestor(node: Node) -> Bool {
//        return self == node ? false : pathToRoot.contains(node)
//    }
//    
//    /**
//     - returns: Ancestral `Node` at a given distance, if present. Otherwise `nil`.
//     */
//    public func ancestor(at distance: Int) -> Node? {
//        guard distance < pathToRoot.count else { return nil }
//        return pathToRoot[distance]
//    }
//}
