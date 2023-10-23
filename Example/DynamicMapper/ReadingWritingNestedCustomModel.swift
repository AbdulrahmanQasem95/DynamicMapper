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
            level_4 = dm.level1?.level2?.level3?.level4?.objectValue(customType: Level4Model.self)
            level_6_Array = dm.level1?.level2?.level3?.level4?.level5?.level6Array?.arrayValue(type: .customObject(ofType: ArrayItemModel.self))
        case .encoding:
            dm.level1?.level2?.level3?.level4?.setDynamicProperty(customObject: level_4)
            dm.level1?.level2?.level3?.level4?.level5?.level6Array?.setDynamicProperty(customArray: level_6_Array ?? [])
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
