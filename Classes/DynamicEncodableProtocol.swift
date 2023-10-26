//
//  DynamicEncodableProtocol.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation

public protocol DynamicEncodable:Encodable,AnyObject{
    var  dynamicSelf:DynamicClass? { get set  }
    func dynamicMapping(mappingType:DynamicMappingType)
}

