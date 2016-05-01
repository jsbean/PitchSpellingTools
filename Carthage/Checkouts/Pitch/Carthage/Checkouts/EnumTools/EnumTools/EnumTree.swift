//
//  EnumTree.swift
//  EnumTools
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Wrap a many-cased Enum with a hierarchical structure.
 */
public protocol EnumTree {
    
    // MARK: - AssociatedTypes
    
    /// Source Enum type.
    associatedtype EnumKind
    
    /**
     A subclass of EnumTree conforming class which contains `static` properties pointing to
     
     - specific cases of the `EnumKind` type
     - subfamilies, each a subclass of an `EnumFamily` conforming class
    */
    associatedtype EnumFamily = Self
    
    // MARK: - Type Properties
    
    /// Individual cases of the `EnumKind` type
    static var members: [EnumKind] { get }
    
    /// Subclasses of `EnumFamily` conforming class, containing `members` and / or `subfamiles`.
    static var subFamilies: [EnumFamily.Type] { get }

    // MARK: - Type Methods
    
    /**
     - returns: `true` if `members` or any subFamily's `members` contains `kind` value. 
     Otherwise `false`.
     */
    static func has(kind: EnumKind) -> Bool
}

extension EnumTree where
    EnumKind: Equatable,
    EnumFamily: EnumTree,
    EnumFamily.EnumKind == EnumKind
{
    
    /**
     - note: Returns `[]`. Override in embedded subclasses to return all appropriate cases.
     */
    public static var members: [EnumKind] { return [] }
    
    /**
     - note: Returns `[]`. Override in embedded subclasses to return all appropriate values.
    */
    public static var subFamilies: [EnumFamily.Type] { return [] }
    
    /**
     - returns: `true` if `members` or any subFamily's `members` contains `kind` value.
     */
    public static func has(kind: EnumKind) -> Bool {
        if members.contains(kind) { return true }
        for family in subFamilies { if family.has(kind) { return true } }
        return false
    }
}