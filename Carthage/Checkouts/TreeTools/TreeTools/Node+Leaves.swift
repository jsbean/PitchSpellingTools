////
////  Node+Leaves.swift
////  TreeTools
////
////  Created by James Bean on 3/11/16.
////  Copyright © 2016 James Bean. All rights reserved.
////
//
//import Foundation
//import DirectionTools
//import ArrayTools
//
//extension Node {
//    
//    // MARK: - Leaves
//
//    /// If Node is a Leaf (has no children Nodes)
//    public var isLeaf: Bool { return children.count == 0 }
//    
//    /// All Leaf Nodes
//    public var leaves: [Node] {
//        
//        func descendToGetLeaves(of node: Node, inout result: [Node]) {
//            if node.isLeaf { result.append(node) }
//            else {
//                for child in node.children {
//                    descendToGetLeaves(of: child, result: &result)
//                }
//            }
//        }
//        
//        var result: [Node] = []
//        descendToGetLeaves(of: self, result: &result)
//        return result
//    }
//    
//    /**
//     - returns: Leaf `Node` at given index, is present. `nil` if index out of range.
//     */
//    public func leaf(at index: Int) -> Node? {
//        guard index >= 0 && index < leaves.count else { return nil }
//        return leaves[index]
//    }
//    
//    /// Leaf Node to Left (may cross hierarchical levels)
//    public var leafLeft: Node? { return getLeafToDirection(.Left) }
//    
//    /// Lead Node to Right (may cross hierarchical levels)
//    public var leafRight: Node? { return getLeafToDirection(.Right) }
//    
//    private func getLeafToDirection(direction: RelativeDirectionKind) -> Node? {
//        guard RelativeDirection.X.has(direction) else { return nil }
//        guard let index = root.leaves.index(ofObject: self) else { return nil }
//        if direction == .Left && index > 0 {
//            return root.leaves[index - 1]
//        } else if direction == .Right && index < root.leaves.count - 1 {
//            return root.leaves[index + 1]
//        }
//        return nil
//    }
//}