//
//  DynamicJSONDecoder.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
public class DynamicJSONDecoder {
    
    public init(){}
    //dedoding method
    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : DynamicDecodable {
        if var serializedDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
            performDynamicModelInjection(dic: &serializedDictionary)
            let endoedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            let decoder = JSONDecoder()
            var model = try decoder.decode(T.self, from: endoedData)
            model.dynamicMapping(mappingType: .decoding)
            return model
        }else {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return model
        }
    }
    
    //custom array dedoding method
    public func decode<T>(_ type: [T].Type, from data: Data) throws -> [T] where T : DynamicDecodable {
        if var serializedDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]{
            for (index,item) in serializedDictionary.enumerated() {
                var serializedItem =  item
                performDynamicModelInjection(dic: &serializedItem)
                serializedDictionary[index] = serializedItem
            }
            let endoedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            let decoder = JSONDecoder()
            var models = try decoder.decode([T].self, from: endoedData)
            //TODO: solve this for value type -done but need test-
            for (index,item) in models.enumerated() {
                var mutatingItem = item
                mutatingItem.dynamicMapping(mappingType: .decoding)
                models[index] = mutatingItem
            }
            //model.forEach({$0.dynamicMapping(mappingType: .decoding)})
            return models
        }else {
            let decoder = JSONDecoder()
            let model = try decoder.decode([T].self, from: data)
            return model
        }
    }
    
    //inject DynamicSelf-self copy- model
    private func performDynamicModelInjection(dic:inout [String:Any]) {
        if !dic.keys.contains(dynamicSelf) {
            dic[dynamicSelf] = dic
        }
        for key in dic.keys {
            if  key != dynamicSelf, var internalDic = dic[key] as? [String:Any] {
                performDynamicModelInjection(dic: &internalDic)
                dic[key] = internalDic
            }else if  key != dynamicSelf, var internalArray = dic[key] as? [[String:Any]] {
                for (index,_) in internalArray.enumerated() {
                    performDynamicModelInjection(dic: &internalArray[index])
                }
                dic[key] = internalArray
            }
        }
    }
}

