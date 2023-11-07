//
//  BaseDynamicCodable.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation

//should match dynamicSelf parameter in DynamicDecodable protocol
let dynamicSelf = "dynamicSelf"

public protocol BaseDynamicCodable{
    mutating func dynamicMapping(mappingType:DynamicMappingType)
    var  dynamicSelf:DynamicClass? { get set }
    /// ds stands for Dynamic Self
    /// an alias of dynamicSelf property
    var  ds:DynamicClass {  get }
}

extension BaseDynamicCodable {
    public var ds: DynamicClass {
        get {
            if let dynamicSelf = dynamicSelf {
                return dynamicSelf
            }else {
                return DynamicClass([:])
            }
           
        }
    }
}

extension Array where Element:BaseDynamicCodable{
    mutating public func dynamicMapping(mappingType:DynamicMappingType) {
        var array = self
        for var item in self {
            item.dynamicMapping(mappingType: mappingType)
            array.append(item)
        }
        self = array
    }
}
