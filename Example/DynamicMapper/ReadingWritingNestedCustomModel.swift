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
    {
        get{dm.level1?.level2?.level3?.level4?.objectValue(customType: Level4Model.self)}
        set{dm.level1?.level2?.level3?.level4?.setDynamicProperty(customObject: newValue)}
    }
    
    var level_6_Array:[ArrayItemModel] {
        get{dm.level1?.level2?.level3?.level4?.level5?.level6Array?.arrayValue(type: .customObject(ofType: ArrayItemModel.self)) ?? []}
        set{
            dm.level1?.level2?.level3?.level4?.level5?.level6Array?.setDynamicProperty(customArray: newValue)
        }
    }
    
}

class Level4Model:DynamicCodable{
    var dynamicSelf:DynamicClass?
    var property4:String
}

class ArrayItemModel:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var item1:String
    var item2:Int
}
