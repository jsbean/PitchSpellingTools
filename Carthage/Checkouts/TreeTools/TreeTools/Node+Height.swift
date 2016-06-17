////
////  Node+Height.swift
////  TreeTools
////
////  Created by James Bean on 3/11/16.
////  Copyright © 2016 James Bean. All rights reserved.
////
//
//import Foundation
//
//extension Node {
//    
//    // MARK: - Height
//    
//    /// Height of Tree containing Node
//    public var heightOfTree: Int { return root.height }
//    
//    /// Height of Node in Tree (amount of levels before Leaf descendent)
//    public var height: Int {
//        
//        func descendToGetHeight(of node: Node, result: Int) -> Int {
//            if node.isLeaf { return result }
//            return node.children
//                .map { descendToGetHeight(of: $0, result: result + 1) }
//                .reduce(0, combine: max)
//        }
//        
//        return descendToGetHeight(of: self, result: 0)
//    }
//}
