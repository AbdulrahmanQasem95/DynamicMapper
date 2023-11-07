//
//  CustomInsertModel.swift
//  DynamicMapper_Example
//
//  Created by Abdulrahman Qasem on 07/11/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import DynamicMapper

class CustomInsertModel:DynamicEncodable {
    var dynamicSelf: DynamicClass?
    
    var firstName = "Abedulrahman"
    var lastName  = "Qasem"
    var email     = "Abdulrahmanq1995@gmail.com"
    
    func dynamicMapping(mappingType: DynamicMappingType) {}
    
}
