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
        value.dynamicMapping(mappingType: .encoding)
        let endoedData = try JSONEncoder().encode(value)
      //TODO: more testing on the cleaned model
        //TODO: test when decode none dynamic decoded model
        // procedure: convert model to a dictionary using json serialization
        // fill the model based on dynamicSelf object and give the priority to the original model if the value is exist on the main model then override the
        if var serializedDictionary = try JSONSerialization.jsonObject(with: endoedData, options: []) as? [String:Any]{
            dataCleaning(dic: &serializedDictionary)
            let cleanedEndoedData = try JSONSerialization.data(withJSONObject: serializedDictionary)
            return cleanedEndoedData
        }
        return endoedData
    }
    
    //TODO: change method name to more suitable one
   private func dataCleaning(dic:inout [String:Any]) {
        if var innerDynamicSelf = dic[dynamicSelf] as? [String:Any] {
            for key in dic.keys {
                // give the priority to the defined in model item over dynamic self item
                if var internalDic = dic[key] as?  [String:Any], key != dynamicSelf {
                    //handel internalModels
                    dataCleaning(dic: &internalDic)
                    innerDynamicSelf[key] = internalDic
                }else  if  var internalArray = dic[key] as?  [Any], key != dynamicSelf {
                    // handel array of properties and it can be array of arrays
                    arrayDataCleaning(array: &internalArray)
                    innerDynamicSelf[key] = internalArray
                }else if key != dynamicSelf  {
                    //handel property
                    innerDynamicSelf[key] = dic[key]
                }
            }
            dic = innerDynamicSelf
        }
    }
    //TODO: change method name to more suitable one
    private func arrayDataCleaning(array:inout [Any]) {
        for item in array {
            if var innerItem = item as? [String:Any] {
                dataCleaning(dic: &innerItem)
            }else if var innerArray = item as? [Any] {
                arrayDataCleaning(array: &innerArray)
            }
        }
    }
}


