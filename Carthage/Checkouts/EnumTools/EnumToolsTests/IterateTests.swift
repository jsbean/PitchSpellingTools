//
//  IterateTests.swift
//  EnumTools
//
//  Created by James Bean on 2/24/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import EnumTools

class IterateTests: XCTestCase {

    func testIterate() {
        
        enum TestEnum { case a, b, c, d, e, f, g }
        
        var enumCollection: [TestEnum] = []
        for el in iterateEnum(TestEnum.self) { enumCollection.append(el) }
        
        let expected: [TestEnum] = [.a, .b, .c, .d, .e, .f, .g]
        XCTAssertEqual(enumCollection, expected)
    }
    
    func testAllCases() {
        
        enum TestEnum: String { case A, B, C, D, E, F, G }
        let expected: [TestEnum] = [.A, .B, .C, .D, .E, .F, .G]
        XCTAssert(TestEnum.allCases == expected)
    }
}
