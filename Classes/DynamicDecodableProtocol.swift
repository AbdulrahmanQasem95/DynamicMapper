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
    // dm stands for Dynamic Mapper
    // an alias of dynamicSelf
    var  dm:DynamicClass? {  get }
}

extension DynamicDecodable {
    public var dm: DynamicClass? {
        get {
            return dynamicSelf
        }
    }
}

