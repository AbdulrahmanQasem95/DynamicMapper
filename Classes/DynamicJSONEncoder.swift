//
//  DynamicJSONDecoder.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
class DynamicJSONEncoder {
    func encode<T>(_ value: T) throws -> Data where T : DynamicEncodable{
        let ecoder = JSONEncoder()
        return try ecoder.encode(value)
    }
}
