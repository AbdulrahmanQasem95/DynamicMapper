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
    var property2:Int {dm.level1?.level2?.property2?.intValue ?? 0}
    var property4:String
    {
        get{dm.level1?.level2?.level3?.level4?.property4?.stringValue ?? ""}
        set{dm.level1?.level2?.level3?.level4?.property4?.setDynamicProperty(value: newValue)}
    }
    
    var secondArrayItem1OfLevel6:String {dm.level1?.level2?.level3?.level4?.level5?.level6Array?[1]?.item1?.stringValue ?? "item not found" }
    
    var thirdArrayItem2OfLevel6:Int
    {
        get {dm.level1?.level2?.level3?.level4?.level5?.level6Array?[2]?.item2?.intValue ?? 0}
        set{dm.level1?.level2?.level3?.level4?.level5?.level6Array?[2]?.item2?.setDynamicProperty(value: newValue)}
    }
   
    //this will not cause index out of range error
    var nonExitArrayItem:Int {dm.level1?.level2?.level3?.level4?.level5?.level6Array?[39845983453453]?.item2?.intValue ?? 0}
    
   
}
