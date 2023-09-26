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
           // dynamicClass.array[0].fetchNestedItems()
            print("arrayitem: \(dynamicClass.array[0].bodyme ?? "")")
            dynamicClass.array[0].bodyme = "Abed"
            print("arrayitem: \(dynamicClass.array[0].bodyme ?? "")")
           // dynamicClass.array[0].intenralArray[0].fetchNestedItems()
            print("arrayitem: \(dynamicClass.array[0].intenralArray[0].bodyinternalDynamic ?? "")")
            
            
            let data = try? DynamicJSONEncoder().encode(dynamicClass)
            
            if let dynamic = try? decoder.decode(NestedClass.self, from: data!) {
                print("total name: \(dynamic.nameTotal)")
                //dynamic.fetchNestedItems()
                print("name: \(dynamic.name ?? "")")
                
               // dynamic.array[0].fetchNestedItems()
                print("arrayitem: \(dynamic.array[0].bodyme ?? "")")
                
               // dynamic.array[0].intenralArray[0].fetchNestedItems()
                print("arrayitem: \(dynamic.array[0].intenralArray[0].bodyinternalDynamic ?? "")")
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

    var nameTotal:String?
    var name :String? {
        marwan.dynamicSelf?.yazan?.mazen?.stringValue
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
    var bodyme:String? {
        get {
            dynamicSelf?.body?.stringValue ?? ""
        }
        set {
            dynamicSelf?.body?.setDynamicProperty(value: newValue )
        }
        
    }
//    lazy var bodyme:String? = {
//        dynamicSelf?.body?.stringValue ?? ""
//    }()
    var flag:Bool
    var intenralArray:[IntenralArray]
 
}

class IntenralArray:DynamicCodable {
    var dynamicSelf: DynamicMapper.DynamicClass?
    var bodyinternal:String
    var bodyinternalDynamic:String? {
        dynamicSelf?.bodyinternal?.stringValue ?? ""
    }
 
    
}
