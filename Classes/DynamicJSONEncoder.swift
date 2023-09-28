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
//        let ecoder = JSONEncoder()
////        if let dynamicObject = value.dynamicSelf{
////            return try ecoder.encode(dynamicObject)
////        }else {
//            return try ecoder.encode(value)
//       // }
        let endoedData = try JSONEncoder().encode(value)
//        //TODO: remove dynamic self from all nested classes after set it to it is corrsponding property
//        if value.dynamicSelf != nil {
//            if let serializedDictionary = try JSONSerialization.jsonObject(with: endoedData, options: []) as? [String:Any] {
//                var topDynamicDic = serializedDictionary[dynamicSelf] as! [String:Any]
//                performDynamicSelfCleaner(topDynamicDic: &topDynamicDic, dic: serializedDictionary)
//                return try JSONSerialization.data(withJSONObject: topDynamicDic)
//            }
//        }
        return endoedData
    }
    
//    func performDynamicSelfCleaner(topDynamicDic:inout [String:Any], dic: [String:Any]) {
//
//        for key in dic.keys {
//            if key != dynamicSelf, let innerDic = dic[key] as? [String:Any]  {
//                topDynamicDic[key] = innerDic[dynamicSelf]
//                topDynamicDic.removeValue(forKey: dynamicSelf)
//                if var innerTopDynamicSelf = topDynamicDic[key] as? [String:Any] {
//                    performDynamicSelfCleaner(topDynamicDic: &innerTopDynamicSelf, dic: innerDic)
//                    topDynamicDic[key] = innerTopDynamicSelf
//                }else if  var innerTopDynamicSelf = topDynamicDic[key] as? [[String:Any]] {
////                    for item in innerTopDynamicSelf {
////
////                    }
//                }
//            }else if key != dynamicSelf, let innerArray = dic[key] as? [[String:Any]] {
//                var finalArray:[[String:Any]] = []
//                for (index,item) in innerArray.enumerated() {
//                    if let innerTopDynamicSelfArray = topDynamicDic[key] as? [[String:Any]], innerTopDynamicSelfArray.count == innerArray.count {
//                        var innerTopDynamicSelfArrayItem = innerTopDynamicSelfArray[index]
//                        performDynamicSelfCleaner(topDynamicDic: &innerTopDynamicSelfArrayItem, dic: item)
//                        finalArray.append(innerTopDynamicSelfArrayItem)
//                    }
//                }
//                topDynamicDic[key] =  finalArray
//            }else if key != dynamicSelf {
//                topDynamicDic[key] = dic[key]
//            }
//        }
//    }
}


