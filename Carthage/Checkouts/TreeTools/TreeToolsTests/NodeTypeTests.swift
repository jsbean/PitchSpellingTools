//
//  NodeTypeTests.swift
//  TreeTools
//
//  Created by James Bean on 6/10/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import QuartzCore
@testable import TreeTools

final class C: NodeType {
    var parent: C?
    var children: [C] = []
}

class NodeTypeTests: XCTestCase {
    
    var c = C()
}
