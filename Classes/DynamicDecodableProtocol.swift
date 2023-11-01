//
//  DynamicDecodableProtocol.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
//should match dynamicSelf parameter in DynamicDecodable protocol
let dynamicSelf = "dynamicSelf"

public protocol DynamicDecodable:BaseDynamicCodable,Decodable{
    var  dynamicSelf:DynamicClass? { get set }
    /// dm stands for Dynamic Mapper
    /// an alias of dynamicSelf
    var  ds:DynamicClass? {  get }
}

extension DynamicDecodable {
    public var ds: DynamicClass? {
        get {
            return dynamicSelf
        }
    }
}

