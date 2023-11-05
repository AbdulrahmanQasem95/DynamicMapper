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
    //MARK:  example use different names than json keys
    //MARK:  test for value and refernce types
    //MARK:  code documentation above each method and var
    //TODO:  clean project
    let data = JsonReader.getJsonSampleData()
    let decoder = DynamicJSONDecoder()
    let encoder = DynamicJSONEncoder()
    let realm = try! Realm()
    var model:ReadingWritingNestedPropertiesModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: reading and wirting nested properties
    @IBAction func readFromJson(_ sender: UIButton) {
        if let model = try?  decoder.decode(ReadingWritingNestedPropertiesModel.self, from: data) {
            
            print("property 0: \(model.property0)")
            print("property 2: \(model.property_2)")
            
            print("property 4: \(model.property_4)")
            model.property_4? += " modefied"
            print("property 4: \(model.property_4)")
            
            
            //print("level 6 second array item1: \(model.secondArrayItem1OfLevel6)")
            
            print("level 6 third array item2: \(model.thirdArrayItem_2_OfLevel_6)")
            model.thirdArrayItem_2_OfLevel_6? += 10
            print("level 6 third array item2: \(model.thirdArrayItem_2_OfLevel_6)")
            
            print("non exit array item: \(model.nonExitArrayItem)")
            self.model = model
        }
    }
    
    
    //MARK: reading and writing from nested definded model that containd dynamic properties
    @IBAction func writeToRealm(_ sender: UIButton) {
        if let model = model {
            try! realm.write {
                realm.add(model)
            }
        }
    }
    
    //MARK:  reading and writing nested custom models
    @IBAction func readFromRealm(_ sender: UIButton) {
        
        if let model = model {
            try! realm.write {
                realm.delete(model)
            }
        }
        
        if let model = model , !model.isInvalidated {
            print("model available")
        }else{
            print("model not available")
            model?.property_4 = "2"
        }
        
        
        
        
        
//        let realmModels =  realm.objects(ReadingWritingNestedPropertiesModel.self)
//        let firstRealmModel = realmModels[0]
//        print("property 0: \(firstRealmModel.property0)")
//        print("property 2: \(firstRealmModel.property_2)")
//        print("property 4: \(firstRealmModel.property_4)")
//        print("level 6 third array item2: \(firstRealmModel.thirdArrayItem_2_OfLevel_6)")
//        print("non exit array item: \(firstRealmModel.nonExitArrayItem)")
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
//        print(String(data: encodedData, encoding: .utf8))
        guard let decodedModel = try?  decoder.decode(ReadingWritingNestedDefinedModel.self, from: encodedData) else {return}
        print("\nAfter endode and decode model again:")
        print("property 0: \(decodedModel.property0)")
        print("property 5: \(decodedModel.level1.level2.property_5)")
        print("Array second item item1: \(model.level1.level2.secondArrayItem_1_OfLevel_6)")
    }
    
}





//class arrayItem:DynamicCodable {
//    var dynamicSelf: DynamicMapper.DynamicClass?
//    
//    var title:String
//    
////    var bodyme:String? {
////        get {
////            dynamicSelf?.body?.stringValue
////        }
////        set {
////            dynamicSelf?.body?.setDynamicProperty(value: newValue )
////        }
////    }
//    //MARK: Realm format
////    @objc dynamic var bodyme:String {
////        get{
////            dm.intenralArray?[0]?.bodyinternal?.stringValue ?? ""
////        }
////        set{
////            dm.intenralArray?[0]?.bodyinternal?.setDynamicProperty(value: newValue )
////        }
////    }
////    @objc dynamic private var bodyme_holder:String?
////    var bodyme:String? {
////        get {
////            bodyme_holder ?? dynamicSelf?.body?.stringValue
////        }
////        set {
////            bodyme_holder = newValue
////            dynamicSelf?.body?.setDynamicProperty(value: bodyme_holder )
////        }
////    }
//    
////    @objc dynamic private var bodyme:String? = {dynamicSelf?.body?.stringValue}()
//
//    //MARK: Normal get set format
////    lazy var bodyme:String? = dynamicSelf?.intenralArray?[0]?.bodyinternal?.stringValue
////    {
////        didSet {
////            //TODO: need to test with dynamic items
////            dynamicSelf?.intenralArray?[0]?.bodyinternal?.setDynamicProperty(value: bodyme ?? "" )
////        }
////    }
////
//    var bodyme:String {
//        get{
//            dm.intenralArray?[0]?.bodyinternal?.stringValue ?? ""
//        }
//        set{
//            dm.intenralArray?[0]?.bodyinternal?.setDynamicProperty(value: newValue )
//        }
//    }
////
////
//    
//    
//    //MARK: Normal get only
//    //var bodyme:String? {dynamicSelf?.body?.stringValue}
//  
////    lazy var bodyme:String? = {
////        dynamicSelf?.body?.stringValue ?? ""
////    }() {
////        didSet {
////            dynamicSelf?.body?.setDynamicProperty(value: bodyme ?? "")
////        }
////    }
//    var flag:Bool
//   // var intenralArray:[IntenralArray]
// 
//}
//
//
//
//struct DM<T:Codable>:Codable{
//
//    var path:DynamicValue?
//    var value:T?
//    func set(_ value: T){
//
//    }
//
//    init(path:DynamicValue?) {
//        self.path = path
//    }
//    func get() -> T?{
//       return value
//    }
////    subscript() -> T{
////        set{
////            path?.setDynamicProperty(value: "name")
////        }
////        get{
////            return "" as! T
////        }
////    }
//    init(from decoder: Decoder) throws {
//        let value = try? T(from: decoder)
//        self.value = value
//    }
//
//    func encode(to encoder: Encoder) throws {
//        if let value = value {
//            try "\(value)".encode(to: encoder)
//        }
//    }
//    
//}
//
//class test:DynamicCodable {
//    var dynamicSelf: DynamicMapper.DynamicClass?
//
//   // var myValue: DM<Int> = DM(path: dm.what?.ksdhjsf)
//    var myValue:Int
//    func dsdf() {
////        myValue.set(30)
////        let i = myValue.get()
//    }
//}
//
//
