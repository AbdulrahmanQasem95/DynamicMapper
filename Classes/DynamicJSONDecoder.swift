//
//  DynamicJSONDecoder.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
class DynamicJSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : DynamicDecodable {
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: data)
        model.mapping()
        return model
    }
}
