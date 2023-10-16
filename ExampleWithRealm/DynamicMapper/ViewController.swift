//
//  ViewController.swift
//  DynamicMapper
//
//  Created by Abdulrahman Qasem on 09/19/2023.
//  Copyright (c) 2023 Abdulrahman Qasem. All rights reserved.
//

import UIKit
import DynamicMapper
import RealmSwift
class ViewController: UIViewController {
    
    
    //MARK: forth example about reading and writing and compatility with Realm
    
    let data = JsonReader.getJsonSample1Data()
    let decoder = DynamicJSONDecoder()
    let encoder = DynamicJSONEncoder()
    let realm = try! Realm()
    
    var model:ReadingWritingNestedPropertiesModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: reading and wirting nested properties
    @IBAction func example1Action(_ sender: UIButton) {
        if let model = try?  decoder.decode(ReadingWritingNestedPropertiesModel.self, from: data) {
            
            print("property 0: \(model.property0)")
            print("property 2: \(model.property2)")
            
            print("property 4: \(model.property4)")
            model.property4 += " modefied"
            print("property 4: \(model.property4)")
            
            
            //print("level 6 second array item1: \(model.secondArrayItem1OfLevel6)")
            
            print("level 6 third array item2: \(model.thirdArrayItem2OfLevel6)")
            model.thirdArrayItem2OfLevel6 += 10
            print("level 6 third array item2: \(model.thirdArrayItem2OfLevel6)")
            
            print("non exit array item: \(model.nonExitArrayItem)")
            self.model = model
        }
    }
    
    @IBAction func writeToRealmDB(_ sender: UIButton) {
        if let model = model {
            try! realm.write {
                realm.add(model)
            }
        }
       
    }
    
    //MARK: reading and writing from nested definded model that containd dynamic properties
    @IBAction func readFromRealmDBAction(_ sender: UIButton) {
        let realmModels =  realm.objects(ReadingWritingNestedPropertiesModel.self)
        let firstRealmModel = realmModels[0]
        print("property 0: \(firstRealmModel.property0)")
        print("property 2: \(firstRealmModel.property2)")
        print("property 4: \(firstRealmModel.property4)")
        print("level 6 third array item2: \(firstRealmModel.thirdArrayItem2OfLevel6)")
        print("non exit array item: \(firstRealmModel.nonExitArrayItem)")
    }
    
  
}
