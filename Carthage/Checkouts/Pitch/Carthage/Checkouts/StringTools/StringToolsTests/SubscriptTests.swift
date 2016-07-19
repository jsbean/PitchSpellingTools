//
//  SubscriptTests.swift
//  StringTools
//
//  Created by James Bean on 2/24/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import StringTools

class SubscriptTests: XCTestCase {

    func testSubscriptCharacterNil() {
        let string = ""
        let newVal: Character? = string[0]
        XCTAssertNil(newVal)
    }
    
    func testSubscriptCharacterValid() {
        let string = "string"
        let newVal: Character? = string[4]
        XCTAssertEqual(newVal!, Character("n"))
    }
    
    func testSubscriptStringNil() {
        let string = ""
        let newVal: String? = string[0]
        XCTAssertNil(newVal)
    }
    
    func testSubscriptStringValid() {
        let string = "string"
        let newVal: String? = string[2]
        XCTAssertEqual(newVal, "r")
    }
}
