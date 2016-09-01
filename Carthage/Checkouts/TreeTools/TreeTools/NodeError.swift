//
//  NodeError.swift
//  TreeTools
//
//  Created by James Bean on 7/21/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Error thrown when doing bad things to a `NodeType`-conforming object.
 */
public enum NodeError: Error {
    
    /// Error thrown when trying to insert a Node at an invalid index
    case insertionError
    
    /// Error thrown when trying to remove a Node from an invalid index
    case removalError
    
    /// Error thrown when trying to insert a Node at an invalid index
    case nodeNotFound
}
