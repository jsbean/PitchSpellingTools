//
//  RelativeDirection+Y.swift
//  DirectionTools
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

extension RelativeDirection {
    
    public class Y: RelativeDirection {
        
        public static var Up: RelativeDirectionKind = .Up
        public static var Down: RelativeDirectionKind = .Down
        
        public override class var members: [RelativeDirectionKind] { return [ Up, Down ] }
    }
}