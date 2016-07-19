//
//  Comparable.swift
//  EnumTools
//
//  Created by James Bean on 5/11/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public func < <T: RawRepresentable where T.RawValue: Comparable>(a: T, b: T) -> Bool {
    return a.rawValue < b.rawValue
}