//
//  NestedPropertiesModel.swift
//  DynamicMapper_Example
//
//  Created by Abdulrahman Qasem on 05/10/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import DynamicMapper

class NestedPropertiesModel:DynamicCodable{
    var dynamicSelf:DynamicClass?
    
    var property0:String
    var property01:Int
    var property02:Double
    var property03:Bool
    var property04:String
    var property_2:Int?
    var property_4:String?
    var flaotv:Float?
    var datev:Date?
    var urlv:URL?
    var secondArrayItem_1_OfLevel_6:String?
    var thirdArrayItem_2_OfLevel_6:Int?
    var nonExitArrayItem:Int? 
    
    func dynamicMapping(mappingType: DynamicMapper.DynamicMappingType) {
        switch mappingType {
        case .decoding:
            property_2                  <--   ds.level1.level2.property2
            property_4                  <--   ds.level1.level2.level3.level4.property4
            flaotv                      <--   ds.level1.flaotV
            datev                       <--   ds.level1.dateV
            urlv                        <--   ds.level1.urlv
            secondArrayItem_1_OfLevel_6 <--   ds.level1.level2.level3.level4.level5.level6Array[1].item1
            thirdArrayItem_2_OfLevel_6  <--   ds.level1.level2.level3.level4.level5.level6Array[2].item2
            //this will not cause index out of range error
            nonExitArrayItem            <--   ds.level1.level2.level3.level4.level5.level6Array[39845983453453].item2
        case .encoding:
            property_2                  -->  {ds.level1.level2.property2.set($0)}
            property_4                  -->  {ds.level1.level2.level3.level4.property4.set($0)}
            secondArrayItem_1_OfLevel_6 -->  {ds.level1.level2.level3.level4.level5.level6Array[1].item1.set($0)}
            thirdArrayItem_2_OfLevel_6  -->  {ds.level1.level2.level3.level4.level5.level6Array[2].item2.set($0)}
            nonExitArrayItem            -->  {ds.level1.level2.level3.level4.level5.level6Array[39845983453453].item2.set($0)}
        }
    }
   
}
