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
            performDynamicInjection(dic: &serializedDictionary)
            let endoedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: endoedData)
            model.dynamicMapping(mappingType: .decoding)
            return model
        }else {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return model
        }
    }
    
    private func performDynamicInjection(dic:inout [String:Any]) {
        if !dic.keys.contains(dynamicSelf) {
            dic[dynamicSelf] = dic
        }
        for key in dic.keys {
            if  key != dynamicSelf, var internalDic = dic[key] as? [String:Any] {
                performDynamicInjection(dic: &internalDic)
                dic[key] = internalDic
            }else if  key != dynamicSelf, var internalArray = dic[key] as? [[String:Any]] {
                for (index,_) in internalArray.enumerated() {
                    performDynamicInjection(dic: &internalArray[index])
                }
                dic[key] = internalArray
            }
        }
    }

}

