//
//  Stack.swift
//  ArrayTools
//
//  Created by James Bean on 2/24/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

/**
 Implementation of Stack structure.
 
 - TODO: Conform to `SequenceType` and `ComparableType`.
 */
public struct Stack<Element: Equatable> {
    
    fileprivate var items: [Element] = []
    
    // MARK: - Instance Properties
    
    /// Last element in `Stack`.
    public var top: Element? { return items.last }
    
    // MARK: - Initializers
    
    /**
     Create an empty `Stack`.
     
     - returns: Initialized `Stack`
     */
    public init() { }
    
    /**
     Create a `Stack` with the elements of an `Array`.
     */
    public init(_ items: [Element]) {
        self.items = items
    }
    
    /**
     Create a `Stack` with items.
     */
    public init(_ items: Element...) {
        self.items = items
    }
    
    // MARK: - Instance Methods
    
    /**
     Push item to end of `Stack`.
     */
    public mutating func push(_ item: Element) {
        items.append(item)
    }
    
    /**
     Pop item from end of `Stack`.
     */
    public mutating func pop() -> Element? {
        if items.count == 0 { return nil }
        return items.removeLast()
    }
    
    /**
     - returns: `Stack` containing items popped from end of `Stack`
     */
    public mutating func pop(amount: Int) throws -> Stack<Element> {
        guard items.count > amount else { throw ArrayError.removalError }
        var poppedItems: Stack<Element> = Stack()
        for _ in 0..<amount { poppedItems.push(pop()!) }
        return poppedItems
    }
}

// MARK: - Equatable

extension Stack: Equatable { }

/**
 - returns: `true` if all items in both `Stack` structs are equivalent. Otherwise `false`.
 */
public func == <T>(lhs: Stack<T>, rhs: Stack<T>) -> Bool {
    return lhs.items == rhs.items
}
