//
//  ReadingWritingNestedCustomModel.swift
//  DynamicMapper_Example
//
//  Created by Abdulrahman Qasem on 05/10/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import DynamicMapper
class ReadingWritingNestedCustomModel :DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property0:String
    var level_4:Level4Model?
    var level_6_Array:[ArrayItemModel]?
    
    func dynamicMapping(mappingType: DynamicMappingType) {
        switch mappingType {
        case .decoding:
            level_4        <--  ds?.level1?.level2?.level3?.level4
            level_6_Array  <--  ds?.level1?.level2?.level3?.level4?.level5?.level6Array
        case .encoding:
            level_4        --> {ds?.level1?.level2?.level3?.level4?.set($0)}
            level_6_Array  --> {ds?.level1?.level2?.level3?.level4?.level5?.level6Array?.set($0)}
        }
    }
    
}

class Level4Model:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property4:String
    
    func dynamicMapping(mappingType: DynamicMappingType) {}
}

class ArrayItemModel:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var item1:String
    var item2:Int
    
    func dynamicMapping(mappingType: DynamicMappingType) {}
}
