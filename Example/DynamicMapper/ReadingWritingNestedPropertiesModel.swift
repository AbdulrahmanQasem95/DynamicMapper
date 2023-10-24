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
            property_2                  <- dm.level1?.level2?.property2
            property_4                  <- dm.level1?.level2?.level3?.level4?.property4
            secondArrayItem_1_OfLevel_6 <- dm.level1?.level2?.level3?.level4?.level5?.level6Array?[1]?.item1
            thirdArrayItem_2_OfLevel_6  <- dm.level1?.level2?.level3?.level4?.level5?.level6Array?[2]?.item2
            //this will not cause index out of range error
            nonExitArrayItem            <- dm.level1?.level2?.level3?.level4?.level5?.level6Array?[39845983453453]?.item2
        case .encoding:
//            var dd = dm.level1?.level2?.property2
//            property_2 >>> dd
//            dm
            dm.level1?.level2?.property2?.set(property_2)
            dm.level1?.level2?.level3?.level4?.property4?.set(property_4)
            dm.level1?.level2?.level3?.level4?.level5?.level6Array?[1]?.item1?.set(secondArrayItem_1_OfLevel_6)
            dm.level1?.level2?.level3?.level4?.level5?.level6Array?[2]?.item2?.set(thirdArrayItem_2_OfLevel_6)
            dm.level1?.level2?.level3?.level4?.level5?.level6Array?[39845983453453]?.item2?.set(nonExitArrayItem)
        }
    }
   
}
