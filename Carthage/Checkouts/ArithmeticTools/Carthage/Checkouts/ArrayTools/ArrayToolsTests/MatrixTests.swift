//
//  MatrixTests.swift
//  ArrayTools
//
//  Created by James Bean on 9/18/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import ArrayTools

class MatrixTests: XCTestCase {
    
    func testInit() {
        let amountRows: UInt = 2
        let amountColumns: UInt = 3
        let matrix = Matrix<Int>(amountRows: amountRows, amountColumns: amountColumns)
        for row in 0 ..< amountRows {
            for column in 0 ..< amountColumns {
                XCTAssertEqual(matrix[row, column], 0)
            }
        }
    }
    
    func testSubscript() {
        let amountRows: UInt = 2
        let amountColumns: UInt = 3
        var matrix = Matrix<Int>(amountRows: amountRows, amountColumns: amountColumns)
        matrix[1,2] = 1
        XCTAssertEqual(matrix[1,2], 1)
    }
    
    func testSequence() {
        let matrix = Matrix<Int>(amountRows: 3, amountColumns: 3)
        XCTAssertEqual(matrix.map { $0 }.count, 9)
    }
}
