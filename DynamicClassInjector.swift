//
//  DynamicClassInjector.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 24/09/2023.
//

//import Foundation
//func performDynamicInjection( dic:inout [String:Any]) {
//    if !dic.keys.contains(dynamicSelf) {
//        dic[dynamicSelf] = dic
//    }
//    for key in dic.keys {
//        if  key != dynamicSelf, var internalDic = dic[key] as? [String:Any] {
//           // internalDic[dynamicSelf] = internalDic
//            //dic[key] = internalDic
//            performDynamicInjection(dic: &internalDic)
//            dic[key] = internalDic
//        }else if  key != dynamicSelf, var internalArray = dic[key] as? [[String:Any]] {
//            for (index,_) in internalArray.enumerated() {
//               // internalArray[index][dynamicSelf] =  internalArray[index]
//                performDynamicInjection(dic: &internalArray[index])
//            }
//            dic[key] = internalArray
//        }
//    }
//}
