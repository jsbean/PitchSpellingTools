//
//  Copyable.swift
//  CopyTools
//
//  Created by James Bean on 3/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Enable deep copying of reference values
 */
public protocol Copyable {
    
    // MARK: - Initializers
    
    /**
     Create a copy of an object, which is referentially inequal.
     
     - parameter copy: The object to copy
     
     - returns: An initialized object whose fields are logically equivalent to the original,
        though is referentially inequal
     */
    init(copy: Self)
}

public extension Copyable {
    
    // MARK: - Instance Methods
    
    /**
     Get a deep copy of an object, that are reference inequal.
     
     - returns: A deep copy of an object
     */
    func copy() -> Self {
        return Self.init(copy: self)
    }
}