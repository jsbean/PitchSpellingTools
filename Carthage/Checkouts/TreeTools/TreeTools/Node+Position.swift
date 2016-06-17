////
////  Node+Position.swift
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
//    // MARK: - Position of Node
//    
//    /// Position of Node in a context (e.g., either an entire Tree, or an internal Node).
//    public enum Position {
//        
//        /// Node is only Node in containing context
//        case Only
//        
//        /// Node is the first Node in containing context
//        case First
//        
//        /// Node is somewhere in the middle of containing context
//        case Middle
//        
//        /// Node is the last Node in containing context
//        case Last
//    }
//    
//    /**
//     `Position` of Node in context of its containing Tree.
//     */
//    public var positionInTree: Position? {
//        if isRoot { return nil }
//        if leafLeft == nil && leafRight == nil { return .Only}
//        if leafLeft == nil && leafRight != nil { return .First }
//        if leafLeft != nil && leafRight == nil { return .Last }
//        else { return .Middle }
//    }
//    
//    /**
//     `Position` of Node in context of its containing internal Node.
//     
//     - TODO: Manage `nil` first, abort immediately if `isRoot`.
//     */
//    public var positionInContainer: Position? {
//        if
//            (siblingLeft == nil || siblingLeft!.isContainer) &&
//            (siblingRight == nil || siblingRight!.isContainer)
//        {
//            return .Only
//        }
//        if
//            (siblingLeft == nil || siblingLeft!.isContainer) &&
//            (siblingRight != nil && siblingRight!.isLeaf)
//        {
//            return .First
//        }
//        if
//            (siblingLeft != nil && siblingLeft!.isLeaf) &&
//            (siblingRight == nil || siblingRight!.isContainer)
//        {
//            return .Last
//        }
//        else { return .Middle }
//    }
//}
