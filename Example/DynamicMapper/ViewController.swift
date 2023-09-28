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
          "title": "test",
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
        let decoder = DynamicJSONDecoder()
        if let dynamicClass = try?  decoder.decode(NestedClass.self, from: jsonData) {
            print("total name: \(dynamicClass.nameTotal )")
            //dynamicClass.fetchNestedItems()
            print("name: \(dynamicClass.name ?? "")")
            dynamicClass.name = "edit mazen"
            print("name: \(dynamicClass.name ?? "")")
           // dynamicClass.array[0].fetchNestedItems()
            print("arrayitem: \(dynamicClass.array[0].bodyme ?? "")")
            print("arrayitem: \(dynamicClass.dynamicSelf?.array?[0]?.body?.stringValue ?? "")")
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




class NestedClass:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?

    var nameTotal:String
    var name :String? {
        get {
            marwan.dynamicSelf?.yazan?.mazen?.stringValue
        }
        set {
            marwan.dynamicSelf?.yazan?.mazen?.setDynamicProperty(value: newValue ?? "" )
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


struct arrayItem:DynamicCodable {
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
//    @objc dynamic private var bodyme_holder:String? = ""
//    var bodyme:String? {
//        get {
//            bodyme_holder ?? dynamicSelf?.body?.stringValue
//        }
//        set {
//            bodyme_holder = newValue
//            dynamicSelf?.body?.setDynamicProperty(value: bodyme_holder )
//        }
//    }
    //MARK: Normal get set format
    lazy var bodyme:String? = dynamicSelf?.intenralArray?[0]?.bodyinternal?.stringValue
    {
        didSet {
            //TODO: need to test with dynamic items
            dynamicSelf?.intenralArray?[0]?.bodyinternal?.setDynamicProperty(value: bodyme ?? "" )
        }
    }
    //MARK: Normal get only
   // var bodyme:String? {dynamicSelf?.body?.stringValue}
  
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
        dynamicSelf?.bodyinternal?.stringValue ?? ""
    }
 
    
}
