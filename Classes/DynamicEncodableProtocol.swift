//
//  DynamicEncodableProtocol.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation

public protocol DynamicEncodable:BaseDynamicCodable,Encodable{
    var  dynamicSelf:DynamicClass? { get set  }
}

