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
    let jsonData = """
    {
    "nameTotal": "Qasem",
      "aps": {
        "mutable-content": 1,
        "alert": {
          "title": "Alert name test",
          "body": "test",
          "flag": true
        },
        "badge": 11,
        "sound": "default"
      },
       "array": [{
          "title": "testaaaa",
          "body": "testItem0",
          "flag": true,
           "intenralArray":[{
              "bodyinternal": "testInternalItem0"
    }
    ]
        },{
          "title": "test22",
          "body": "test22",
          "flag": true,
           "intenralArray":[{
              "bodyinternal": "testInternalItem0"
    }
    ]
        }],
    "marwan":{
    "yazan":{
    "mazen":"mazzzzzen"
    }
    }
    }
    """.data(using: .utf8)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = Bundle.main.url(forResource: "jsonExample", withExtension: "JSON") else {
            return
        }
        var data: Data = Data()
        do {
            data = try Data(contentsOf: url)
            print(String(data: data, encoding: .utf8))
        } catch let error {
            print(error.localizedDescription)
        }
        
        let decoder = DynamicJSONDecoder()
        if let json = try?  decoder.decode(JsonExample.self, from: data) {
            print(json.dm.level1?.level2?.level3?.property3?.stringValue ?? "")
            print(json.dm.level1?.level2?.level3?.level4?.level5?.level6Array?[1]?.item2?.stringValue ?? "")
            json.dm.level1?.level2?.level3?.level4?.level5?.level6Array?[1]?.item2?.setDynamicProperty(value: "Item D modefied")
            print(json.dm.level1?.level2?.level3?.level4?.level5?.level6Array?[1]?.item2?.stringValue ?? "")
        }
        
        
        
        
        if let dynamicClass = try?  decoder.decode(NestedClass.self, from: jsonData) {
            print("total name: \(dynamicClass.nameTotal )")
            print("alert name: \(dynamicClass.dm.aps?.alert?.objectValue(customType: Alert.self)?.title ?? "" )")
            print("alert name: \(dynamicClass.dm.aps?.alert?.objectValue(customType: Alert.self)?.title ?? "" )")

            //dynamicClass.fetchNestedItems()
            print("name: \(dynamicClass.name ?? "")")
            dynamicClass.name = "edit mazen"
            print("name: \(dynamicClass.name ?? "")")
           // dynamicClass.array[0].fetchNestedItems()
            print("arrayitem: \(dynamicClass.array[0].bodyme ?? "")")
          //  print("bodyinternal: \(dynamicClass.arrrrrr[0].bodyinternal ?? "")")
            print("arrayitem: \(dynamicClass.dynamicSelf?.array?[0]?.body?.stringValue ?? "")")
            print("arrayitem: \(dynamicClass.dynamicSelf?.bosddy?.sdfsd?.stringValue ?? "")")
            dynamicClass.array[0].bodyme = "Abed"
            print("arrayitem: \(dynamicClass.array[0].bodyme ?? "")")
            print("arrayitem: \(dynamicClass.dynamicSelf?.array?[0]?.body?.stringValue ?? "")")
           // dynamicClass.array[0].intenralArray[0].fetchNestedItems()
           // print("arrayitem: \(dynamicClass.array[0].intenralArray[0].bodyinternalDynamic ?? "")")
            
            
            let data = try? DynamicJSONEncoder().encode(dynamicClass)
            
            if let dynamic = try? decoder.decode(NestedClass.self, from: data!) {
                print("total name: \(dynamic.nameTotal)")
                //dynamic.fetchNestedItems()
                print("name: \(dynamic.name ?? "")")
                
               // dynamic.array[0].fetchNestedItems()
                print("arrayitem: \(dynamic.array[0].bodyme ?? "")")
                print("arrayitem: \(dynamic.dynamicSelf?.array?[0]?.body?.stringValue ?? "")")
                print("alert name: \(dynamic.dm.aps?.alert?.objectValue(customType: Alert.self)?.title ?? "" )")
                print("alert name: \(dynamic.dm.aps?.alert?.objectValue(customType: Alert.self)?.title ?? "" )")
               // dynamic.array[0].intenralArray[0].fetchNestedItems()
              //  print("arrayitem: \(dynamic.array[0].intenralArray[0].bodyinternalDynamic ?? "")")
            }
          
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


class JsonExample:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?
}

class NestedClass:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?

    var nameTotal:String
    var name :String? {
        get {
            //marwan.dm.yazan?.mazen?.stringValue
            marwan.dm.asdf?.asfd?.stringValue
        }
        set {
            marwan.dm.asdf?.asfd?.setDynamicProperty(value: newValue ?? "" )
        }
    }
    var marwan:Marwan
    var array:[arrayItem]
}

class Marwan:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?
   // var mazen :String?
    var yazan:Yazan?
 
    
}

class Yazan:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?
    var mazen :String?
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

class IntenralArray:DynamicCodable {
    var dynamicSelf: DynamicMapper.DynamicClass?
    var bodyinternal:String
    var bodyinternalDynamic:String? {
         get {
             dm.bodyinternal?.stringValue ?? ""
        }
        set {
            dm.bodyinternal?.setDynamicProperty(value: "")
        }
    }
 
    
}


class Alert:DynamicCodable {
    var dynamicSelf: DynamicMapper.DynamicClass?
    var title:String
    var body:String
    var flag: Bool
    
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


