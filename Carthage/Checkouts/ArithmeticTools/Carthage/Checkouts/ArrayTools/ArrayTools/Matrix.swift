//
//  Matrix.swift
//  ArrayTools
//
//  Created by James Bean on 9/18/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

/// Types that can be initialized with no external information.
public protocol EmptyInitializable {
    init()
}

extension Int: EmptyInitializable { }
extension Float: EmptyInitializable { }
extension Double: EmptyInitializable { }

/// Two dimensional storage of `EmptyInitializable`-conforming types.
public struct Matrix<T: EmptyInitializable> {
    
    private let amountRows: UInt
    private let amountColumns: UInt
    
    fileprivate var grid: [T] = []
    
    /// Create a matrix with the given amount of rows and columns.
    public init(amountRows: UInt, amountColumns: UInt) {
        self.amountRows = amountRows
        self.amountColumns = amountColumns
        self.grid = Array(repeating: T(), count: Int(amountRows * amountColumns))
    }
    
    /// Get and set the value for the given `row` and `column`.
    public subscript (row: UInt, column: UInt) -> T {
        
        get {
            precondition(indexIsValid(row, column))
            return grid[Int((row * column) + column)]
        }
        
        set {
            precondition(indexIsValid(row, column))
            grid[Int((row * column) + column)] = newValue
        }
    }
    
    private func indexIsValid(_ row: UInt, _ column: UInt) -> Bool {
        return row < amountRows && column < amountColumns
    }
}

extension Matrix: Sequence {
    
    public func makeIterator() -> AnyIterator<T> {
        var iterator = grid.makeIterator()
        return AnyIterator { return iterator.next() }
    }
}

/// - returns: `true` if all values of both matrices are equivalent. Otherwise, `false`.
public func == <T: Equatable> (lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
    return lhs.grid == rhs.grid
}
