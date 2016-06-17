//
//  TestRecursiveClass.swift
//  CopyTools
//
//  Created by James Bean on 3/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import CopyTools

public class TestRecursiveClass: Copyable {
    
    public let value: Int
    public var parent: TestRecursiveClass?
    public var children: [TestRecursiveClass] = []
    
    public init(
        value: Int,
        parent: TestRecursiveClass? = nil,
        children: [TestRecursiveClass] = []
    )
    {
        self.value = value
        self.parent = parent
        self.children = children
    }
    
    public required init(copy: TestRecursiveClass) {
        self.value = copy.value
        self.parent = copy.parent
        self.children = copy.children
    }
}

extension TestRecursiveClass: Equatable { }

public func == (lhs: TestRecursiveClass, rhs: TestRecursiveClass) -> Bool {
    return (
        lhs.value == rhs.value &&
        lhs.parent == rhs.parent &&
        lhs.children == rhs.children
    )
}