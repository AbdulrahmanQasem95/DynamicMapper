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
        if var serializedDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
            dynamicClassInjector(dic: &serializedDictionary)
            let endoedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: endoedData)
            return decodedData
        }else {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        }
    }
}

