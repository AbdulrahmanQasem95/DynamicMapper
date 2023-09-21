//
//  DynamicJSONDecoder.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
public class DynamicJSONDecoder {
    public init(){}
    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : DynamicDecodable {
        let decoder = JSONDecoder()
        var model = try decoder.decode(T.self, from: data)
        let dynamicModel = try decoder.decode(DynamicClass.self, from: data)
        model.dynamicSelf = dynamicModel
        model.fetchNestedItems()
        return model
    }
}
