//
//  DynamicJSONDecoder.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
public class DynamicJSONEncoder {
    public init(){}
    //T should conform to DynamicCodable not only DynamicEncodable to make sure it was decoded by DynamicDecodable
    public func encode<T>(_ value: T) throws -> Data where T : DynamicCodable{
        value.dynamicMapping(mappingType: .encoding)
        let encodedData = try JSONEncoder().encode(value)
      //TODO: more testing on the cleaned model
        //TODO: test when decode none dynamic decoded model
        // procedure: convert model to a dictionary using json serialization
        // fill the model based on dynamicSelf object and give the priority to the original model if the value is exist on the main model then override the
        if var serializedDictionary = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String:Any]{
            performDynamicModelExtraction(dic: &serializedDictionary)
            let cleanedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            let decodedCleanedModel = try JSONDecoder().decode(T.self, from: cleanedData)
            let endoedCleanedData = try JSONEncoder().encode(decodedCleanedModel)
            return endoedCleanedData
        }
        return encodedData
    }
    
    //T should conform to DynamicCodable not only DynamicEncodable to make sure it was decoded by DynamicDecodable
    public func encode<T>(_ value: [T]) throws -> Data where T : DynamicCodable{
        value.forEach({$0.dynamicMapping(mappingType: .encoding)})
        let encodedData = try JSONEncoder().encode(value)
        if var serializedDictionary = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [[String:Any]]{
            for (index,item) in serializedDictionary.enumerated() {
                var serializedItem =  item
                performDynamicModelExtraction(dic: &serializedItem)
                serializedDictionary[index] = serializedItem
            }
            let cleanedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            let decodedCleanedModel = try JSONDecoder().decode([T].self, from: cleanedData)
            let endoedCleanedData = try JSONEncoder().encode(decodedCleanedModel)
            return endoedCleanedData
        }
        return encodedData
    }
    
   private func performDynamicModelExtraction(dic:inout [String:Any]) {
        if var innerDynamicSelf = dic[dynamicSelf] as? [String:Any] {
            for key in dic.keys {
                // give the priority to the defined in model item over dynamic self item
                if var internalDic = dic[key] as?  [String:Any], key != dynamicSelf {
                    //handle internal Models
                    performDynamicModelExtraction(dic: &internalDic)
                    innerDynamicSelf[key] = internalDic
                }else  if  var internalArray = dic[key] as?  [Any], key != dynamicSelf {
                    // handle array of properties or dimensional array (array of arrays)
                    recursivelyCleanArray(array: &internalArray)
                    innerDynamicSelf[key] = internalArray
                }else if key != dynamicSelf  {
                    //handle property
                    innerDynamicSelf[key] = dic[key]
                }
            }
            dic = innerDynamicSelf
        }
    }
    
    private func recursivelyCleanArray(array:inout [Any]) {
        for item in array {
            if var innerItem = item as? [String:Any] {
                performDynamicModelExtraction(dic: &innerItem)
            }else if var innerArray = item as? [Any] {
                recursivelyCleanArray(array: &innerArray)
            }
        }
    }
}


