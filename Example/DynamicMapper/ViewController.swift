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
    
    //MARK: done---- reading and writing and compatility with Realm
    //MARK: done---- example use different names than json keys
    //MARK: done---- test for value and refernce types
    //MARK: done---- support codable types (flaot, date, data,url)
    //TODO: done---- clean project
    //TODO: done---- test json insertion
    //MARK: code documentation above each method and var
    //MARK: example enhancement
    //MARK: pod document
    let data = JsonReader.getJsonSampleData()
    let decoder = DynamicJSONDecoder()
    let encoder = DynamicJSONEncoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: reading and wirting nested properties
    @IBAction func nestedPropertiesAction(_ sender: UIButton) {
        decoder.dateDecodingStrategy = .iso8601
        if let model = try?  decoder.decode(NestedPropertiesModel.self, from: data) {
            print("property 0: \(model.property0)")
            print("property 01: \(model.property01)")
            print("property 02: \(model.property02)")
            print("property 03: \(model.property03)")
            print("property 04: \(model.property04)")
            print("property 04: \(model.flaotv)")
            print("property 04: \(model.datev)")
            print("property 04: \(model.urlv)")
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
    
    
    //MARK: reading and writing from inner model that contains dynamic properties
    @IBAction func innerModelAction(_ sender: UIButton) {
        if let model = try?  decoder.decode(ReadingWritingInnerModel.self, from: data) {
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
    @IBAction func nestedCustomModelAction(_ sender: UIButton) {
        if let model = try?  decoder.decode(NestedCustomModel.self, from: data) {
            print("property 0: \(model.property0)")
            print("property 4: \(model.level_4?.property4 ?? "not found")")
            
            print("Array second item item1: \(model.level_6_Array?[1].item1)")
            model.level_6_Array?[1].item1 += " modified"
            print("Array second item item1: \(model.level_6_Array?[1].item1)")
        }
    }
    
    
    //MARK: Dynamic Encoding
    @IBAction func encodingAction(_ sender: UIButton) {
        
        guard var model = try?  decoder.decode(ReadingWritingInnerModel.self, from: data) else {return}
        print("property 0: \(model.property0)")
        model.property0 += " modified"
        print("property 0: \(model.property0)")
        
        print("property 5: \(model.level1.level2.property_5)")
        model.level1.level2.property_5? += " modified"
        print("property 5: \(model.level1.level2.property_5)")
        
        print("Array second item item1: \(model.level1.level2.secondArrayItem_1_OfLevel_6)")
        model.level1.level2.secondArrayItem_1_OfLevel_6? += " modified"
        model.ds.custom[0].custom2.set(["check my love"])
        model.ds.custom[1].custom1.set(2)
        print("Array second item item1: \(model.level1.level2.secondArrayItem_1_OfLevel_6)")
        
        guard let encodedData = try?  encoder.encode(model) else {return}
        print(String(data: encodedData, encoding: .utf8))
        guard let decodedModel = try?  decoder.decode(ReadingWritingInnerModel.self, from: encodedData) else {return}
        print("\nAfter endode and decode model again:")
        print("property 0: \(decodedModel.property0)")
        print("property 5: \(decodedModel.level1.level2.property_5)")
        print("Array second item item1: \(model.level1.level2.secondArrayItem_1_OfLevel_6)")
    }
    
    @IBAction func customPropertyNameExample(_ sender: UIButton) {
        guard let model = try?  decoder.decode(CustomPropertyNameModel.self, from: data) else {return}
        print("property 0 custom name: \(model.property0_CustomName)")
        model.property0_CustomName? += " modified"
        print("property 0 custom name: \(model.property0_CustomName)")
        
        print("property 04 custom name: \(model.property04_CustomName)")
        
        
        guard let encodedData = try?  encoder.encode(model) else {return}
        guard let decodedModel = try?  decoder.decode(CustomPropertyNameModel.self, from: encodedData) else {return}
        print("\nAfter endode and decode model again:")
        print("property 0 custom name: \(decodedModel.property0_CustomName)")
        print("property 04 custom name: \(decodedModel.property04_CustomName)")
    }
    
    
    
    @IBAction func ValueTypeExample(_ sender: UIButton) {
        
        if var model = try?  decoder.decode(ValueTypeModel.self, from: data) {
            print("property 0:  \(model.property0)")
            print("property 01: \(model.property01)")
            print("property 02: \(model.property02)")
            print("property 03: \(model.property03)")
            print("property 04: \(model.property04)")
            print("property 2:  \(model.property_2 ?? 0)")
            print("property 4:  \(model.property_4 ?? "")")
            model.property_4? += " modefied"
            print("property 4: \(model.property_4 ?? "")")
            print("level 6 second array item1: \(model.secondArrayItem_1_OfLevel_6 ?? "")")
            print("level 6 third array item2: \(model.thirdArrayItem_2_OfLevel_6 ?? 0)")
            model.thirdArrayItem_2_OfLevel_6? += 10
            print("level 6 third array item2: \(model.thirdArrayItem_2_OfLevel_6 ?? 0)")
            print("non exit array item: \(model.nonExitArrayItem ?? 0)")
            
            guard let encodedData = try?  encoder.encode(model) else {return}
            guard let decodedModel = try?  decoder.decode(ValueTypeModel.self, from: encodedData) else {return}
            print("\nAfter endode and decode model again:")
            print("property 0: \(decodedModel.property0)")
            print("property 01: \(decodedModel.property01)")
            print("property 02: \(decodedModel.property02)")
            print("property 03: \(decodedModel.property03)")
            print("property 04: \(decodedModel.property04)")
            print("property 2: \(decodedModel.property_2 ?? 0)")
            print("property 4: \(decodedModel.property_4 ?? "")")
            print("level 6 second array item1: \(decodedModel.secondArrayItem_1_OfLevel_6 ?? "")")
            print("level 6 third array item2: \(decodedModel.thirdArrayItem_2_OfLevel_6 ?? 0)")
            print("non exit array item: \(decodedModel.nonExitArrayItem ?? 0)")

        }
    }
}
