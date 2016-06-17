////
////  Node+Children.swift
////  TreeTools
////
////  Created by James Bean on 3/11/16.
////  Copyright © 2016 James Bean. All rights reserved.
////
//
//import Foundation
//
//extension Node {
//
//    // MARK: - Children
//    
//    /**
//     Add child Node to Node
//     
//     - parameter node: child Node
//     
//     - returns: Node object
//     */
//    public func addChild(node: Node) {
//        children.append(node)
//        node.parent = self
//    }
//    
//    /**
//     Add an indeterminate amount of child Nodes.
//     
//     - parameter nodes: Child Nodes to add
//     */
//    public func addChildren(nodes: Node...) {
//        addChildren(nodes)
//    }
//    
//    /**
//     Add an array of child Nodes.
//     
//     - parameter nodes: Child nodes to add
//     */
//    public func addChildren(nodes: [Node]) {
//        nodes.forEach { addChild($0) }
//    }
//    
//    /**
//     - parameter child: `Node` to insert
//     - parameter index: Index at which to insert `child`
//     
//     - throws: `Error.InsertionError` if index out of range
//     */
//    public func insert(child: Node, atIndex index: Int) throws {
//        if index > children.count { throw Error.InsertionError }
//        children.insert(child, atIndex: index)
//        child.parent = self
//    }
//    
//    /**
//     - parameter node: `Node` to remove, if it is a child
//     
//     - throws: `Error.NodeNotFound` if `node` is not a child
//     */
//    public func removeChild(node: Node) throws {
//        guard let index = children.indexOf(node) else { throw Error.NodeNotFound }
//        try removeChild(at: index)
//    }
//    
//    /**
//     - parameter index: Index of child to remove
//     
//     - throws: `Error.NodeNotFound` if no child exists at `index`
//     */
//    public func removeChild(at index: Int) throws {
//        if index >= children.count { throw Error.NodeNotFound }
//        children.removeAtIndex(index)
//    }
//    
//    /**
//     Check if Node has a specific Child
//     
//     - parameter node: potential child Node
//     
//     - returns: `true` if has child `node`. Otherwise `false`.
//     */
//    public func hasChild(node: Node) -> Bool {
//        for child in children { if child == node { return true } }
//        return false
//    }
//    
//    /**
//     Get child Node at index
//     
//     - parameter index: index at which Child resides
//     
//     - returns: `Node` residing at `index`, if present. Otherwise `nil`.
//     */
//    public func child(at index: Int) -> Node? {
//        if index >= 0 && index < children.count { return children[index] }
//        return nil
//    }
//}