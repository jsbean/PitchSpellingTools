////
////  Node+Depth.swift
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
//    // MARK: - Depth
//    
//    /// Depth of Node in Tree (amount of levels from Root)
//    public var depth: Int {
//        
//        func ascendToGetDepth(of node: Node, depth: Int) -> Int {
//            guard let parent = node.parent else { return depth }
//            return ascendToGetDepth(of: parent, depth: depth + 1)
//        }
//        
//        return ascendToGetDepth(of: self, depth: 0)
//    }
//}
