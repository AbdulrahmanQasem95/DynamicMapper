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
          "body": "test",
          "flag": true
        },{
          "title": "test22",
          "body": "test22",
          "flag": true
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
            print("dynamic object: \(dynamicClass.name ?? "")")
            let data = try? DynamicJSONEncoder().encode(dynamicClass)
            
            if let dynamic = try? decoder.decode(NestedClass.self, from: data!) {
                print("dynamic object: \(dynamic.name ?? "")")
//                print("dynamic object: \(dynamic.marwan?.yazan?.mazen?.stringValue ?? "")")
               // print("dynamic object: \(dynamic.aps?.badge?.intValue ?? 0)")
                print("dynamic object: \(dynamic.nameTotal )")
               // print("dynamic object: \(dynamic.marwan.mazen ?? "" )")
                print("dynamic object: \(dynamic.marwan.dynamicSelf!.yazan?.mazen?.stringValue ?? "" )")
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
    func fetchNestedItems() {
        name = dynamicSelf?.marwan?.yazan?.mazen?.stringValue ?? ""
    }
}

class Marwan:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?
    var mazen :String?
    func fetchNestedItems() {
        mazen = dynamicSelf?.yazan?.mazen?.stringValue ?? ""
    }
    
}

class Yazan:DynamicCodable{
    var dynamicSelf: DynamicMapper.DynamicClass?
    var mazen :String?
    func fetchNestedItems() {
       // mazen = dynamicSelf?.yazan?.mazen?.stringValue ?? ""
    }
    
}
