//
//  Operators.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 23/10/2023.
//

import Foundation

/// Operator used for read from dynamic model
infix operator <--

/// Operator used for write to dynamic model
infix operator -->


public func <-- (left: inout Int?, right: DynamicValue?) {
    if let value = right?.intValue {
        left = value
    }
}

public func <-- (left: inout String?, right: DynamicValue?) {
    if let value = right?.stringValue  {
        left = value
    }
}

public func <-- (left: inout Bool?, right: DynamicValue?) {
    if let value = right?.boolValue  {
        left = value
    }
}

public func <-- (left: inout Double?, right: DynamicValue?) {
    if let value = right?.doubleValue  {
        left = value
    }
}

public func <-- <T:DynamicDecodable> (left: inout T?, right: DynamicValue?) {
    if let value = right?.objectValue(customType: T.self)  {
        left = value
    }
}

public func <-- <T:DynamicDecodable> (left: inout [T]?, right: DynamicValue?) {
    if let value = right?.customArrayValue(type:  T.self)  {
        left = value
    }
}

public func <-- (left: inout [Int]?, right: DynamicValue?) {
    if let value = right?.intArrayValue() {
        left = value
    }
}
public func <-- (left: inout [String]?, right: DynamicValue?) {
    if let value = right?.stringArrayValue() {
        left = value
    }
}
public func <-- (left: inout [Bool]?, right: DynamicValue?) {
    if let value = right?.boolArrayValue() {
        left = value
    }
}
public func <-- (left: inout [Double]?, right: DynamicValue?) {
    if let value = right?.doubleArrayValue() {
        left = value
    }
}

public func --> <T>(left: T, right:(T) -> Void) {
    right(left)
}
