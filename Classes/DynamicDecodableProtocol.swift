//
//  DynamicDecodableProtocol.swift
//  DynamicMemberLookupTest
//
//  Created by Abdulrahman Qasem on 17/09/2023.
//

import Foundation
//should match dynamicSelf parameter in DynamicDecodable protocol
let dynamicSelf = "dynamicSelf"

public protocol DynamicDecodable:Decodable,AnyObject{
    var dynamicSelf:DynamicClass? { get set }
    var dm:DynamicClass {  get } // stands for DynamicMapper
}
extension DynamicDecodable {
    public var dm: DynamicClass {
         get {
            if let dynamicSelf = dynamicSelf{
                return dynamicSelf
            }else {
                let newDynamicSelf = DynamicClass([:]) // Create a new instance
                self.dynamicSelf = newDynamicSelf // Assign it to the property
                return newDynamicSelf
            }
        }
    }
}

