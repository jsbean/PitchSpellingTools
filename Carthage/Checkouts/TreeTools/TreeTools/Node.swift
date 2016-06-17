//
//  Node.swift
//  TreeTools
//
//  Created by James Bean on 3/1/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import CopyTools
import ArrayTools
import DirectionTools

///**
// Element in a tree structure. May contain 0...n children Nodes, and optionally a parent Node.
// **/
//public class Node: NodeType {
//    
//    // MARK: - Instance Properties
//
//    /// Parent Node
//    public weak var parent: Node?
//    
//    /// Children Nodes
//    public var children: [Node] = []
//    
//    // MARK: - Intializers
//    
//    /**
//    Create a Node
//    
//    - returns: Initialized Node object
//    */
//    public init() { }
//    
//    /**
//     Create a deep copy of a Node which is logically equal, though referentially inequal.
//     
//     - parameter copy: Node to copy
//     
//     - returns: Initialized Node object that is logically equal, though referentially inequal
//     */
//    public required init(copy: Node) {
//        self.parent = copy.parent
//        self.children = copy.children
//    }
//}
//
//// MARK: - Equatable
//extension Node: Equatable { }
//
//public func == (lhs: Node, rhs: Node) -> Bool {
//    return lhs.parent == rhs.parent && lhs.children == rhs.children
//}
