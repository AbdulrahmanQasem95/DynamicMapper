//
//  ViewController.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 09/19/2023.
//  Copyright (c) 2023 Abdulrahman Qasem. All rights reserved.
//

import UIKit
import DynamicMapper
class ViewController: UIViewController {
    
    //MARK: forth example about reading and writing and compatility with Realm
    //MARK:  example use different names than json keys
    //MARK:  test for value and refernce types
    //MARK:  code documentation above each method and var
    //TODO:  clean project
    let data = JsonReader.getJsonSampleData()
    let decoder = DynamicJSONDecoder()
    let encoder = DynamicJSONEncoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: reading and wirting nested properties
    @IBAction func example1Action(_ sender: UIButton) {
        
        
//        if var model = try?  decoder.decode(ReadingWritingNestedPropertiesModelValueType.self, from: data) {
//            print("property 2: \(model.property_2)")
//            model.property_2? += 3
//            print("property 2: \(model.property_2)")
//            
//        }
        if let model = try?  decoder.decode(ReadingWritingNestedPropertiesModel.self, from: data) {
            print("property 0: \(model.property0)")
            print("property 01: \(model.property01)")
            print("property 02: \(model.property02)")
            print("property 03: \(model.property03)")
            print("property 04: \(model.property04)")
            print("property 2: \(model.property_2)")
            
            print("property 4: \(model.property_4)")
            model.property_4? += " modefied"
            print("property 4: \(model.property_4)")
            
            
            print("level 6 second array item1: \(model.secondArrayItem_1_OfLevel_6)")
            
            print("level 6 third array item2: \(model.thirdArrayItem_2_OfLevel_6)")
            model.thirdArrayItem_2_OfLevel_6? += 10
            print("level 6 third array item2: \(model.thirdArrayItem_2_OfLevel_6)")
            
            print("non exit array item: \(model.nonExitArrayItem)")
        }
    }
    
    
    //MARK: reading and writing from nested definded model that containd dynamic properties
    @IBAction func example2Action(_ sender: UIButton) {
        if let model = try?  decoder.decode(ReadingWritingNestedDefinedModel.self, from: data) {
            print("property 0: \(model.property0)")
            print("property 1: \(model.level1.property1)")
            
            print("property 2: \(model.level1.level2.property2)")
            
            print("property 4: \(model.property_4)")
            model.property_4? += " modefied"
            print("property 4: \(model.property_4)")
            
            print("property 5: \(model.level1.level2.property_5)")
            model.level1.level2.property_5? += " modified"
            print("property 5: \(model.level1.level2.property_5)")
            
            print("level 6 second array item1: \(model.level1.level2.secondArrayItem_1_OfLevel_6)")
        }
    }
    
    //MARK:  reading and writing nested custom models
    @IBAction func example3Action(_ sender: UIButton) {
        if let model = try?  decoder.decode(ReadingWritingNestedCustomModel.self, from: data) {
            print("property 0: \(model.property0)")
            print("property 4: \(model.level_4?.property4 ?? "not found")")
            
            print("Array second item item1: \(model.level_6_Array?[1].item1)")
            model.level_6_Array?[1].item1 += " modified"
            print("Array second item item1: \(model.level_6_Array?[1].item1)")
        }
    }
    
    
    //MARK: Dynamic Encoding
    @IBAction func example4Action(_ sender: UIButton) {
        
        guard let model = try?  decoder.decode(ReadingWritingNestedDefinedModel.self, from: data) else {return}
        print("property 0: \(model.property0)")
        model.property0 += " modified"
        print("property 0: \(model.property0)")
        
        print("property 5: \(model.level1.level2.property_5)")
        model.level1.level2.property_5? += " modified"
        print("property 5: \(model.level1.level2.property_5)")
        
        print("Array second item item1: \(model.level1.level2.secondArrayItem_1_OfLevel_6)")
        model.level1.level2.secondArrayItem_1_OfLevel_6? += " modified"
        print("Array second item item1: \(model.level1.level2.secondArrayItem_1_OfLevel_6)")
        
        guard let encodedData = try?  encoder.encode(model) else {return}
        print(String(data: encodedData, encoding: .utf8))
        guard let decodedModel = try?  decoder.decode(ReadingWritingNestedDefinedModel.self, from: encodedData) else {return}
        print("\nAfter endode and decode model again:")
        print("property 0: \(decodedModel.property0)")
        print("property 5: \(decodedModel.level1.level2.property_5)")
        print("Array second item item1: \(model.level1.level2.secondArrayItem_1_OfLevel_6)")
    }
    
}
