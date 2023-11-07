//
//  CustomPropertyNameModel.swift
//  DynamicMapper_Example
//
//  Created by Abdulrahman Qasem on 05/10/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import DynamicMapper

class CustomPropertyNameModel:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property0_CustomName:String?
    var property04_CustomName:String?
    
    func dynamicMapping(mappingType: DynamicMappingType) {
        switch mappingType {
        case .decoding:
            property0_CustomName     <--   ds.property0
            property04_CustomName    <--   ds.property04
        case .encoding:
            property0_CustomName     -->  {ds.property0.set($0)}
            property04_CustomName    -->  {ds.property04.set($0)}
        }
    }
   
}
