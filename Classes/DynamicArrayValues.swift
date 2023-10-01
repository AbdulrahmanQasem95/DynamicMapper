//
//  DynamicArray.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
public enum DynamicArrayValues<T:DynamicDecodable> {
    case int
    case string
    case double
    case bool
    case customObject(ofType:T.Type)
}
