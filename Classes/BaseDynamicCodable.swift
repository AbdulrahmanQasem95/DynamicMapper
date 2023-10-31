//
//  BaseDynamicCodable.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation

public protocol BaseDynamicCodable{
    mutating func dynamicMapping(mappingType:DynamicMappingType)
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
