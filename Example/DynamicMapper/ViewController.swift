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
    //MARK: first example about reading and wirting nested properties
    
    //MARK: second example about reading and writing from nested definded model that containd dynamic properties
    //MARK: third example about reading and writing nested custom models
    //MARK: forth example about reading and writing and compatility with Realm
    
   
    let decoder = DynamicJSONDecoder()
    let encoder = DynamicJSONEncoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let data1 = JsonReader.getJsonSample1Data()
    @IBAction func readingAndWritingNestedPropertiesAction(_ sender: UIButton) {
        if let model = try?  decoder.decode(ReadingWritingNestedPropertiesModel.self, from: data1) {
            
            print("property 0: \(model.property0)")
            print("property 2: \(model.property2)")
            
            print("property 4: \(model.property4)")
            model.property4 += " modefied"
            print("property 4: \(model.property4)")
            
            
            print("level 6 second array item1: \(model.secondArrayItem1OfLevel6)")
            
            print("level 6 third array item2: \(model.thirdArrayItem2OfLevel6)")
            model.thirdArrayItem2OfLevel6 += 10
            print("level 6 third array item2: \(model.thirdArrayItem2OfLevel6)")
            
            print("non exit array item: \(model.nonExitArrayItem)")

        }
    }
    
}





class arrayItem:DynamicCodable {
    var dynamicSelf: DynamicMapper.DynamicClass?
    
    var title:String
    
//    var bodyme:String? {
//        get {
//            dynamicSelf?.body?.stringValue
//        }
//        set {
//            dynamicSelf?.body?.setDynamicProperty(value: newValue )
//        }
//    }
    //MARK: Realm format
//    @objc dynamic var bodyme:String {
//        get{
//            dm.intenralArray?[0]?.bodyinternal?.stringValue ?? ""
//        }
//        set{
//            dm.intenralArray?[0]?.bodyinternal?.setDynamicProperty(value: newValue )
//        }
//    }
//    @objc dynamic private var bodyme_holder:String?
//    var bodyme:String? {
//        get {
//            bodyme_holder ?? dynamicSelf?.body?.stringValue
//        }
//        set {
//            bodyme_holder = newValue
//            dynamicSelf?.body?.setDynamicProperty(value: bodyme_holder )
//        }
//    }
    
//    @objc dynamic private var bodyme:String? = {dynamicSelf?.body?.stringValue}()

    //MARK: Normal get set format
//    lazy var bodyme:String? = dynamicSelf?.intenralArray?[0]?.bodyinternal?.stringValue
//    {
//        didSet {
//            //TODO: need to test with dynamic items
//            dynamicSelf?.intenralArray?[0]?.bodyinternal?.setDynamicProperty(value: bodyme ?? "" )
//        }
//    }
//
    var bodyme:String {
        get{
            dm.intenralArray?[0]?.bodyinternal?.stringValue ?? ""
        }
        set{
            dm.intenralArray?[0]?.bodyinternal?.setDynamicProperty(value: newValue )
        }
    }
//
//
    
    
    //MARK: Normal get only
    //var bodyme:String? {dynamicSelf?.body?.stringValue}
  
//    lazy var bodyme:String? = {
//        dynamicSelf?.body?.stringValue ?? ""
//    }() {
//        didSet {
//            dynamicSelf?.body?.setDynamicProperty(value: bodyme ?? "")
//        }
//    }
    var flag:Bool
   // var intenralArray:[IntenralArray]
 
}



struct DM<T:Codable>:Codable{

    var path:DynamicValue?
    var value:T?
    func set(_ value: T){

    }

    init(path:DynamicValue?) {
        self.path = path
    }
    func get() -> T?{
       return value
    }
//    subscript() -> T{
//        set{
//            path?.setDynamicProperty(value: "name")
//        }
//        get{
//            return "" as! T
//        }
//    }
    init(from decoder: Decoder) throws {
        let value = try? T(from: decoder)
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        if let value = value {
            try "\(value)".encode(to: encoder)
        }
    }
    
}

class test:DynamicCodable {
    var dynamicSelf: DynamicMapper.DynamicClass?

   // var myValue: DM<Int> = DM(path: dm.what?.ksdhjsf)
    var myValue:Int
    func dsdf() {
//        myValue.set(30)
//        let i = myValue.get()
    }
}


