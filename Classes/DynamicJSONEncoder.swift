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
        let endoedData = try JSONEncoder().encode(value)
      //TODO: remove dynamic self from all nested classes after set it to it is corrsponding property
        return endoedData
    }
}


