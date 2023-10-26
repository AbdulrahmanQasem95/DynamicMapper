//
//  DynamicDecodableProtocol.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
//should match dynamicSelf parameter in DynamicDecodable protocol
let dynamicSelf = "dynamicSelf"

public protocol DynamicDecodable:BaseDynamicCodable,Decodable{
    var  dynamicSelf:DynamicClass? { get set }
    var  dm:DynamicClass? {  get } // stands for DynamicMapper
}

extension DynamicDecodable {
    public var dm: DynamicClass? {
        get {
            return dynamicSelf
//            if let dynamicSelf = dynamicSelf{
//                return dynamicSelf
//            }else {
//                let newDynamicSelf = DynamicClass([:])
//               // self.dynamicSelf = newDynamicSelf
//                return newDynamicSelf
//            }
        }
    }
}

