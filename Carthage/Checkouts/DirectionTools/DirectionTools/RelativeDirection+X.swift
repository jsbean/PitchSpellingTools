//
//  RelativeDirection+X.swift
//  DirectionTools
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension RelativeDirection {
    
    public class X: RelativeDirection {
        
        public static var Left: RelativeDirectionKind = .Left
        public static var Right: RelativeDirectionKind = .Right
        
        public override class var members: [RelativeDirectionKind] { return [ Left, Right ] }
    }
}