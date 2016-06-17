////
////  Node+Siblings.swift
////  TreeTools
////
////  Created by James Bean on 3/11/16.
////  Copyright © 2016 James Bean. All rights reserved.
////
//
//import Foundation
//import DirectionTools
//
//extension Node {
//    
//    // MARK: - Siblings
//    
//    /// Sibling Node to left
//    public var siblingLeft: Node? { return getSiblingToDirection(.Left) }
//    
//    /// Sibling Node to Right
//    public var siblingRight: Node? { return getSiblingToDirection(.Right) }
//    
//    private func getSiblingToDirection(direction: RelativeDirectionKind) -> Node? {
//        guard let parent = parent else { return nil }
//        guard RelativeDirection.X.has(direction) else { return nil }
//        guard let i = parent.children.index(ofObject: self) else { return nil }
//        if direction == .Left && i > 0 { return parent.children[i-1] }
//        if direction == .Right && i < parent.children.count - 1 { return parent.children[i+1] }
//        return nil
//    }
//}