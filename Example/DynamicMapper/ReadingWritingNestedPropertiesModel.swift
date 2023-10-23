//
//  ReadingWritingNestedPropertiesModel.swift
//  DynamicMapper_Example
//
//  Created by Abdulrahman Qasem on 05/10/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import DynamicMapper
class ReadingWritingNestedPropertiesModel:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property0:String
    var property_2:Int?
    var property_4:String?
    var secondArrayItem_1_OfLevel_6:String?
    var thirdArrayItem_2_OfLevel_6:Int?
    var nonExitArrayItem:Int? 
    
    func dynamicMapping(mappingType: DynamicMapper.DynamicMappingType) {
        switch mappingType {
        case .decoding:
            property_2 = dm.level1?.level2?.property2?.intValue 
            property_4 = dm.level1?.level2?.level3?.level4?.property4?.stringValue
            secondArrayItem_1_OfLevel_6 = dm.level1?.level2?.level3?.level4?.level5?.level6Array?[1]?.item1?.stringValue
            thirdArrayItem_2_OfLevel_6 = dm.level1?.level2?.level3?.level4?.level5?.level6Array?[2]?.item2?.intValue
            //this will not cause index out of range error
            nonExitArrayItem = dm.level1?.level2?.level3?.level4?.level5?.level6Array?[39845983453453]?.item2?.intValue
        case .encoding:
            dm.level1?.level2?.property2?.setDynamicProperty(value: property_2)
            dm.level1?.level2?.level3?.level4?.property4?.setDynamicProperty(value: property_4)
            dm.level1?.level2?.level3?.level4?.level5?.level6Array?[1]?.item1?.setDynamicProperty(value: secondArrayItem_1_OfLevel_6)
            dm.level1?.level2?.level3?.level4?.level5?.level6Array?[2]?.item2?.setDynamicProperty(value: thirdArrayItem_2_OfLevel_6)
            dm.level1?.level2?.level3?.level4?.level5?.level6Array?[39845983453453]?.item2?.setDynamicProperty(value: nonExitArrayItem)
        }
    }
   
}
