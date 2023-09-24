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
    "nameTotal":"Qasem",
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
          //  print("dynamic object: \(dynamicClass.marwan.dynamicSelf!.yazan?.mazen?.stringValue ?? "" )")
            dynamicClass.fetchNestedItems()
            print("name: \(dynamicClass.name ?? "")")
            dynamicClass.array[0].fetchNestedItems()
            print("arrayitem: \(dynamicClass.array[0].bodyme ?? "")")
            dynamicClass.array[0].intenralArray[0].fetchNestedItems()
            print("arrayitem: \(dynamicClass.array[0].intenralArray[0].bodyinternal ?? "")")
            
            
            let data = try? DynamicJSONEncoder().encode(dynamicClass)
            
            if let dynamic = try? decoder.decode(NestedClass.self, from: data!) {
                print("total name: \(dynamic.nameTotal)")
                dynamic.fetchNestedItems()
                print("name: \(dynamic.name ?? "")")
                
                dynamic.array[0].fetchNestedItems()
                print("arrayitem: \(dynamic.array[0].bodyme ?? "")")
                dynamic.array[0].intenralArray[0].fetchNestedItems()
                print("arrayitem: \(dynamic.array[0].intenralArray[0].bodyinternal ?? "")")
//                print("dynamic object: \(dynamic.marwan?.yazan?.mazen?.stringValue ?? "")")
               // print("dynamic object: \(dynamic.aps?.badge?.intValue ?? 0)")
               //print("dynamic object: \(dynamic.nameTotal )")
               // print("dynamic object: \(dynamic.marwan.mazen ?? "" )")
               //print("dynamic object: \(dynamic.marwan.dynamicSelf!.yazan?.mazen?.stringValue ?? "" )")
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
    var name :String?
    var marwan:Marwan
    var array:[arrayItem]
    func fetchNestedItems() {
      //  name = dynamicSelf?.marwan?.yazan?.mazen?.stringValue ?? ""
        name = marwan.dynamicSelf?.yazan?.mazen?.stringValue ?? ""
        
    }
}

class Marwan:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?
   // var mazen :String?
    var yazan:Yazan?
    func fetchNestedItems() {
        //mazen = dynamicSelf?.yazan?.mazen?.stringValue ?? ""
    }
    
}

class Yazan:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?
    var mazen :String?
    func fetchNestedItems() {
       // mazen = dynamicSelf?.yazan?.mazen?.stringValue ?? ""
    }
    
}


class arrayItem:DynamicCodable {
    var dynamicSelf: DynamicMapper.DynamicClass?
    
    var title:String
    var bodyme:String?
    var flag:Bool
    var intenralArray:[IntenralArray]
    func fetchNestedItems() {
        bodyme = dynamicSelf?.body?.stringValue ?? ""
    }
}

class IntenralArray:DynamicCodable {
    var dynamicSelf: DynamicMapper.DynamicClass?
    var bodyinternal:String
    var bodyinternalDynamic:String?
    func fetchNestedItems() {
        bodyinternalDynamic = dynamicSelf?.bodyinternal?.stringValue ?? ""
    }
    
    
}
