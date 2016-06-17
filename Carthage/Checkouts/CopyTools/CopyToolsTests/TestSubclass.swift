//
//  TestSubclass.swift
//  CopyTools
//
//  Created by James Bean on 3/3/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import CopyTools

public class TestSubclass: TestClass {
    
    public var anotherValue: Int = 0

    public init(anotherValue: Int, value: Int) {
        super.init(value: value)
    }
    
    public convenience init(copy: TestSubclass) {
        self.init(copy: copy)
    }
    
    public required init(copy: TestClass) {
        super.init(value: copy.value)
    }

}