//
//  RelativeDirection+Z.swift
//  DirectionTools
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension RelativeDirection {
    
    public class Z: RelativeDirection {
        
        public static var Forwards: RelativeDirectionKind = .Forwards
        public static var Backwards: RelativeDirectionKind = .Backwards
        
        public override class var members: [RelativeDirectionKind] {
            return [ Forwards,  Backwards ]
        }
    }
}