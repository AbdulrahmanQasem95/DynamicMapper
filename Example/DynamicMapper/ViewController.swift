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
    "mazen":"sdfsdf"
    }
    }
    }
    """.data(using: .utf8)!
    let decoder = DynamicJSONDecoder()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dynamicClass = try? decoder.decode(NestedClass.self, from: jsonData) {
            print("dynamic object: \(dynamicClass.name ?? "")")
            let data = try? JSONEncoder().encode(dynamicClass)
            
            if let dynamic = try? decoder.decode(NestedClass.self, from: data!) {
                print("dynamic object: \(dynamic.name ?? "")")
                print("dynamic object: \(dynamic.marwan?.yazan?.mazen?.stringValue ?? "")")
                print("dynamic object: \(dynamic.aps?.badge?.intValue ?? 0)")
            }
          
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



class NestedClass:DynamicClass{
    var name :String?

    override func mapping() {
        name = self.marwan?.yazan?.mazen?.stringValue ?? ""
    }

}

//class NestedClass:DynamicCodable{
//    var aps:DynamicClass?
//    var marwan:DynamicClass?
//    var name :String?
//
//    func mapping() {
//        name = marwan?.yazan?.mazen?.stringValue ?? ""
//    }
//}

