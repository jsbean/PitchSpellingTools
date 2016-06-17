//
//  TestClass.swift
//  CopyTools
//
//  Created by James Bean on 3/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import CopyTools

public class TestClass: Copyable {
    
    public let value: Int
    
    public required init(copy: TestClass) {
        self.value = copy.value
    }
    
    public init(value: Int) {
        self.value = value
    }
}

extension TestClass: Equatable { }

public func == (lhs: TestClass, rhs: TestClass) -> Bool {
    return lhs.value == rhs.value
}