//
//  DynamicJSONDecoder.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
public class DynamicJSONEncoder {
    
    public init(){}
    
    // Encoding method
    public func encode<T>(_ value: T) throws -> Data where T : DynamicEncodable{
        var mutatingValue = value
        mutatingValue.dynamicMapping(mappingType: .encoding)
        let encodedData = try JSONEncoder().encode(mutatingValue)
        
        if var serializedDictionary = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [String:Any]{
            performDynamicModelExtraction(dic: &serializedDictionary)
            let cleanedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            return cleanedData
        }
        return encodedData
    }
    
    // Custom array encoding method
    public func encode<T>(_ value: [T]) throws -> Data where T : DynamicEncodable{
        var mutatingValues = value
        for (index,item) in mutatingValues.enumerated() {
            var mutatingItem = item
            mutatingItem.dynamicMapping(mappingType: .decoding)
            mutatingValues[index] = mutatingItem
        }
        
        let encodedData = try JSONEncoder().encode(mutatingValues)
        if var serializedDictionary = try JSONSerialization.jsonObject(with: encodedData, options: []) as? [[String:Any]]{
            for (index,item) in serializedDictionary.enumerated() {
                var serializedItem =  item
                performDynamicModelExtraction(dic: &serializedItem)
                serializedDictionary[index] = serializedItem
            }
            let cleanedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            return cleanedData
        }
        return encodedData
    }
    
    // DynamicSelf-model copy- cleaning
    // this will give priority to the item defined in model if exist over the corresponding DynamicSelf item
    private func performDynamicModelExtraction(dic:inout [String:Any]) {
        if var innerDynamicSelf = dic[dynamicSelf] as? [String:Any] {
            for key in dic.keys {
                // this will give priority to the item defined in model if exist over the corresponding DynamicSelf item
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
    
    // clean array from DynamicSelf-model copy-
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


