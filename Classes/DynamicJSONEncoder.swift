//
//  DynamicJSONDecoder.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
public class DynamicJSONEncoder {
    public init(){}
    public func encode<T>(_ value: T) throws -> Data where T : DynamicEncodable{
        let ecoder = JSONEncoder()
        if let dynamicObject = value.dynamicSelf{
            return try ecoder.encode(dynamicObject)
        }else {
            return try ecoder.encode(value)
        }
    }
}
