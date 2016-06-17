//
//  RelativeDirection.swift
//  DirectionTools
//
//  Created by James Bean on 3/1/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import EnumTools

public enum RelativeDirectionKind {
    case Left, Right, Up, Down, Forwards, Backwards
}

public class RelativeDirection: EnumTree {
    
    public typealias EnumKind = RelativeDirectionKind
    public typealias EnumFamily = RelativeDirection
    
    /// Members of `InstrumentFamily`.
    public class var members: [EnumKind] { return [] }
    
    /// SubFamilies of `InstrumentFamily`.
    public class var subFamilies: [EnumFamily.Type] { return [] }
}