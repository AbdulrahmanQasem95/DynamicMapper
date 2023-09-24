//
//  DynamicDecodableProtocol.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
//should match dynamicSelf parameter in DynamicDecodable protocol
let dynamicSelf = "dynamicSelf"

public protocol DynamicDecodable:Decodable{
    var dynamicSelf:DynamicClass? { get set  }
    func fetchNestedItems()
}


