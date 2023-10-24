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
    var property_4:String?
    var level1:Level1Model
    
    func dynamicMapping(mappingType: DynamicMappingType) {
        level1.dynamicMapping(mappingType: mappingType)
        switch mappingType {
        case .decoding:
            property_4 <- dynamicSelf?.level1?.level2?.level3?.level4?.property4
        case .encoding:
            dynamicSelf?.level1?.level2?.level3?.level4?.property4?.set(property_4)
        }
    }
}

class Level1Model:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property1:String
    var level2:Level2Model
    func dynamicMapping(mappingType: DynamicMappingType) {
        level2.dynamicMapping(mappingType: mappingType)
    }
}

class Level2Model:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property2:Int
    var property_5:String?
    var secondArrayItem_1_OfLevel_6:String?
    
    func dynamicMapping(mappingType: DynamicMappingType) {
        switch mappingType {
        case .decoding:
            property_5                  <- dm.level3?.level4?.level5?.property5
            secondArrayItem_1_OfLevel_6 <- dm.level3?.level4?.level5?.level6Array?[1]?.item1
        case .encoding:
            dm.level3?.level4?.level5?.property5?.set(property_5)
            dm.level3?.level4?.level5?.level6Array?[1]?.item1?.set(secondArrayItem_1_OfLevel_6)
        }
    }
}
