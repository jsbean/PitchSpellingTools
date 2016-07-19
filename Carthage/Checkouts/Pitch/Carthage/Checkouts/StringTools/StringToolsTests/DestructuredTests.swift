//
//  DestructuredTests.swift
//  StringTools
//
//  Created by James Bean on 5/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import StringTools

class DestructuredTests: XCTestCase {

    func testHeadTailNil() {
        let string = ""
        XCTAssertNil(string.destructured)
    }
    
    func testHeadTailSingleCharacterNotNil() {
        let string = "1"
        guard let (head, tail) = string.destructured else { XCTFail(); return }
        XCTAssertEqual(head, "1")
        XCTAssertEqual(tail, "")
    }
    
    func testHeadTailMultipleCharactersNotNil() {
        let string = "123"
        guard let (head, tail) = string.destructured else { XCTFail(); return }
        XCTAssertEqual(head, "1")
        XCTAssertEqual(tail, "23")
    }
}
