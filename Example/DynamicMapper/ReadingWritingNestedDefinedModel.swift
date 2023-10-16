//
//  ReadingWritingNestedDefinedModel.swift
//  DynamicMapper_Example
//
//  Created by Abdulrahman Qasem on 05/10/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import DynamicMapper
class ReadingWritingNestedDefinedModel :DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property0:String
    var level1:Level1Model
}

class Level1Model:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property1:String
    var level2:Level2Model
}

class Level2Model:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property2:Int
    
    var property_5:String
    {
        get{dm.level3?.level4?.level5?.property5?.stringValue ?? ""}
        set{dm.level3?.level4?.level5?.property5?.setDynamicProperty(value: newValue)}
    }
    
    var secondArrayItem_1_OfLevel_6:String {
        get{dm.level3?.level4?.level5?.level6Array?[1]?.item1?.stringValue ?? "item not found" }
        set{dm.level3?.level4?.level5?.level6Array?[1]?.item1?.setDynamicProperty(value: newValue)}
    }
}
