//
//  Operators.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 23/10/2023.
//

import Foundation

/// Operator used for read from dynamic model
infix operator <-

/// Operator used for write to dynamic model
infix operator >>>

// MARK:- Objects with Basic types

/// Object of Basic type
//public func <- <T>(left: inout T, right: DynamicValue?) {
//    if left is String || left is  Optional<String> , let value = right?.stringValue as? T  {
//        left = value
//    }else if left is Int || left is Int? , let value = right?.intValue as? T {
//        left = value
//    }else if left is Bool || left is Bool? , let value = right?.boolValue as? T {
//        left = value
//    }else if left is Double || left is Double? , let value = right?.doubleValue as? T {
//        left = value
//    }
//}


public func <- (left: inout Int?, right: DynamicValue?) {
    if let value = right?.intValue {
        left = value
    }
}
public func <- (left: inout String?, right: DynamicValue?) {
    if let value = right?.stringValue  {
        left = value
    }
}

public func <- (left: inout Bool?, right: DynamicValue?) {
    if let value = right?.boolValue  {
        left = value
    }
}

public func <- (left: inout Double?, right: DynamicValue?) {
    if let value = right?.doubleValue  {
        left = value
    }
}
public func <- <T:DynamicDecodable> (left: inout T?, right: DynamicValue?) {
    if let value = right?.objectValue(customType: T.self)  {
        left = value
    }
}

public func <- <T:DynamicDecodable> (left: inout [T]?, right: DynamicValue?) {
    if let value = right?.customArrayValue(type:  T.self)  {
        left = value
    }
}

public func <- (left: inout [Int]?, right: DynamicValue?) {
    if let value = right?.intArrayValue() {
        left = value
    }
}
public func <- (left: inout [String]?, right: DynamicValue?) {
    if let value = right?.stringArrayValue() {
        left = value
    }
}
public func <- (left: inout [Bool]?, right: DynamicValue?) {
    if let value = right?.boolArrayValue() {
        left = value
    }
}
public func <- (left: inout [Double]?, right: DynamicValue?) {
    if let value = right?.doubleArrayValue() {
        left = value
    }
}


//public func >>> <T>(left: inout T, right: inout DynamicValue?) {
//    if left is String || left is String?  {
//        right?.set(left)
//    }
//}

