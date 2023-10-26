//
//  DynamicCodable.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation

public protocol BaseDynamicCodable{
    mutating func dynamicMapping(mappingType:DynamicMappingType)
}
